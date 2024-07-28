# frozen_string_literal: true

require_relative 'generator'
require_relative 'python'

module Generate
  class Arch < Generate::Generator
    # We have two kinds of files to be generated:
    # 1. <arch>.rb, which defines the structure of <arch>_insn.
    # 2. <arch>_const.rb, defines constants of the architecture.

    # Simply use values generated under capstone/bindings/python.
    def gen_consts
      glob('bindings/python/capstone/*_const.py') do |file|
        arch = File.basename(file).sub('_const.py', '')
        res = File.foreach(file).map do |line|
          next '' if line.strip.start_with?('#')

          line.strip.empty? ? "\n" : line.gsub("#{arch.upcase}_", '')
        end.join
        res.gsub!(/\n{3,}/, "\n\n") # Remove more than two empty lines
        res << "\nextend Register"
        write_file("#{arch}_const.rb", "require 'crabstone/arch/register'", module_name(arch), res)

        # Generate spec/arch/*_spec.rb as well
        gen_spec(res, arch)
      end
    end

    def gen_structs
      glob('bindings/python/capstone/*.py') do |file|
        next if file.end_with?('_const.py', '__init__.py')

        py_mod = File.basename(file).sub('.py', '')
        arch = py_mod == 'systemz' ? 'sysz' : py_mod
        mod = module_name(arch)
        content = insert_methods(arch, Python.new(cs_path('bindings/python/capstone'), py_mod).to_layout.join("\n"))
        write_file("#{arch}.rb", <<~REQUIRE, mod, content)
          require 'ffi'

          require 'crabstone/arch/extension'
          require_relative '#{arch}_const'
        REQUIRE
      end
    end

    private

    # insert methods into Operand and Instruction
    def insert_methods(arch, ruby_code)
      op_index = ruby_code.index('class Operand < ')
      return ruby_code if op_index.nil?

      # insert class Operand
      idx = ruby_code.index('end', op_index)
      op_types = File.readlines(File.join(@target_dir, "#{arch}_const.rb"))
                     .map(&:strip)
                     .select { |l| l.start_with?('OP_') && !l.index('OP_INVALID') }
                     .map { |l| l.split(' = ').first.strip[3..] }
      ruby_code.insert(idx, "\n  #{operand_methods(arch, op_types).lines.join('  ')}")

      # insert Instruction
      idx = ruby_code.index('end', ruby_code.index('class Instruction < '))
      ruby_code.insert(idx, "\n  #{<<~RUBY.lines.join('  ')}")
        include Crabstone::Extension::Instruction
      RUBY

      arch_methods(arch, ruby_code)
    end

    def operand_methods(arch, op_types)
      # So sad there're exceptions..
      # TODO: the first blank line is false positive of rubocop: #6264
      return <<~RUBY if arch == 'm68k'

        include Crabstone::Extension::Operand

        # Use Extension::Operand#value first
        alias super_value value

        def value
          super_value || if mem?
                           self[:mem]
                         elsif br_disp?
                           self[:br_disp]
                         elsif reg_bits?
                           self[:register_bits]
                         end
        end

        def reg?
          self[:type] == OP_REG
        end

        def imm?
          self[:type] == OP_IMM
        end

        def mem?
          self[:type] == OP_MEM
        end

        def fp_single?
          self[:type] == OP_FP_SINGLE
        end
        alias simm? fp_single?

        def fp_double?
          self[:type] == OP_FP_DOUBLE
        end
        alias dimm? fp_double?

        def reg_bits?
          self[:type] == OP_REG_BITS
        end

        def reg_pair?
          self[:type] == OP_REG_PAIR
        end

        def br_disp?
          self[:type] == OP_BR_DISP
        end
      RUBY

      normal = <<~RUBY
        include Crabstone::Extension::Operand

        #{op_types.map { |t| "def #{t.downcase}?\n  #{type_check(t, op_types)}\nend" }.join("\n\n")}
      RUBY
      if arch == 'm680x'
        normal += {
          reg: :register,
          imm: :immediate,
          idx: :indexed,
          ext: :extended,
          direct_addr: :direct,
          rel: :relative,
          const_val: :constant
        }.map { |k, v| "alias #{k}? #{v}?\n" }.join
      end
      normal
    end

    # Insert special methods for arm64
    def arch_methods(arch, ruby_code)
      return ruby_code unless arch == 'arm64'

      idx = ruby_code.index(")\n", ruby_code.index('class Operand < ')) + 2
      ruby_code.insert(idx, "  #{<<~RUBY.lines.join('  ')}")
        def shift?
          self[:shift][:type] != SFT_INVALID
        end

        def ext?
          self[:ext] != EXT_INVALID
        end
      RUBY
    end

    # @example
    #   type_check('IMM', ['REG', 'MSR_REG', 'MRS_REG', 'IMM'])
    #   #=> "self[:type] == OP_IMM
    #   type_check('REG', ['REG', 'MSR_REG', 'MRS_REG', 'IMM'])
    #   #=> "[\n  OP_REG,\n  OP_MSR_REG,\n  OP_MRS_REG\n].include?(self[:type])"
    def type_check(type, op_types)
      # XXX: Use `index` maybe have false positive..
      types = op_types.select { |c| c.index(type) }
      return "self[:type] == OP_#{type}" if types.size == 1

      "[\n    #{types.map { |c| "OP_#{c}" }.join(",\n    ")}\n  ].include?(self[:type])"
    end

    def gen_spec(constants, arch)
      types = constants
              .lines
              .select { |c| c.start_with?('OP_') && !c.index('INVALID') }
              .map { |c| c.split('=').first.strip.slice(3..-1).downcase }

      spec_file = File.expand_path(File.join(Dir.pwd, 'spec', 'arch', "#{arch}_spec.rb"))
      return if File.exist?(spec_file)

      puts "Writing #{File.basename(spec_file)}"
      File.binwrite(spec_file, <<~RUBY)
        # frozen_string_literal: true

        require 'crabstone/disassembler'

        describe 'Crabstone::#{module_name(arch)}' do
          def op_of(code, mode, index)
            @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_#{module_name(arch).upcase}, mode)
            cs.decomposer = true
            cs.disasm(code, 0).first.operands[index]
          end

          #{types.map { |t| "it '#{t}' do\n  end" }.join("\n\n  ")}
        end
      RUBY
    end
  end
end
