# frozen_string_literal: true

require 'fileutils'

require 'versionomy'

require_relative 'helper'

desc 'To auto-generate files under lib/crabstone/arch/'
task :gen_arch, :path_to_capstone, :version do |_t, args|
  next if ENV['CI']

  @cs_path = File.expand_path(args.path_to_capstone)
  @version = Versionomy.parse(args.version)
  @target_dir = File.join(__dir__, '..', 'lib', 'crabstone', 'arch', @version.major.to_s)
  include Helper

  FileUtils.mkdir_p(@target_dir)

  # We have two kinds of files to be generated:
  # 1. <arch>.rb, which defines the structure of <arch>_insn.
  # 2. <arch>_const.rb, defines constants in the architecture.

  # TODO: code here is a kind of shit..
  def gen_arch
    glob('bindings/python/capstone/*.py') do |file|
      next if file.end_with?('_const.py', '__init__.py')

      py_mod = File.basename(file).sub('.py', '')
      arch = py_mod == 'systemz' ? 'sysz' : py_mod
      mod = module_name(arch)
      content = insert_methods(arch, Helper::Python.new(py_mod).to_layout.join("\n"))
      write_file(arch + '.rb', mod, content, <<~REQUIRE.strip)
        require 'ffi'

        require_relative '#{arch}_const'
      REQUIRE
    end
  end

  # insert methods into Operand and Instruction
  def insert_methods(arch, ruby_code)
    op_index = ruby_code.index('class Operand < ')
    return ruby_code if op_index.nil?

    # insert class Operand
    idx = ruby_code.index('end', op_index)
    op_types = File.readlines(File.join(@target_dir, arch + '_const.rb'))
                   .map(&:strip)
                   .select { |l| l.start_with?('OP_') && !l.index('OP_INVALID') }
                   .map { |l| l.split(' = ').first.strip[3..-1] }
    ruby_code.insert(idx, "\n  " + <<~RUBY.lines.join('  '))
      def value
        OperandValue.members.find do |s|
          return self[:value][s] if __send__("\#{s}?".to_sym)
        end
      end

      #{op_types.map { |t| "def #{t.downcase}?\n  #{type_check(t, op_types)}\nend" }.join("\n\n")}

      def valid?
        !value.nil?
      end
    RUBY

    # insert Instruction
    idx = ruby_code.index('end', ruby_code.index('class Instruction < '))
    ruby_code.insert(idx, "\n  " + <<~RUBY.lines.join('  '))
      def operands
        self[:operands].take_while { |op| op[:type] != OP_INVALID }
      end
    RUBY

    arch_methods(arch, ruby_code)
  end

  # Insert special methods for arm64
  def arch_methods(arch, ruby_code)
    return ruby_code unless arch == 'arm64'

    idx = ruby_code.index(")\n", ruby_code.index('class Operand < ')) + 2
    ruby_code.insert(idx, '  ' + <<~RUBY.lines.join('  '))
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
    # XXX: Use `index` maybe have false positibe..
    types = op_types.select { |c| c.index(type) }
    return "self[:type] == OP_#{type}" if types.size == 1

    "[\n    #{types.map { |c| 'OP_' + c }.join(",\n    ")}\n  ].include?(self[:type])"
  end

  # Simply use values generated under capstone/bindings/python.
  def gen_const
    glob('bindings/python/capstone/*_const.py') do |file|
      arch = File.basename(file).sub('_const.py', '')
      res = File.foreach(file).map do |line|
        next '' if line.strip.start_with?('#')

        line.strip.empty? ? "\n" : line.gsub("#{arch.upcase}_", '')
      end.join
      res.gsub!(/\n{3,}/, "\n\n") # Remove more than two empty lines
      res << "\nextend Register"
      write_file("#{arch}_const.rb", module_name(arch), res.strip,
                 "require 'crabstone/arch/register'")

      # Generate spec/arch/*_spec.rb as well
      gen_spec(res, arch)
    end
  end

  def gen_spec(constants, arch)
    types = constants
            .lines
            .select { |c| c.start_with?('OP_') && !c.index('INVALID') }
            .map { |c| c.split('=').first.strip.slice(3..-1).downcase }

    spec_file = File.expand_path(File.join(__dir__, '..', 'spec', 'arch', arch + '_spec.rb'))
    return if File.exist?(spec_file)

    puts "Writing #{File.basename(spec_file)}"
    IO.binwrite(spec_file, <<~RUBY)
      # frozen_string_literal: true

      require 'crabstone/disassembler'

      describe Crabstone::#{module_name(arch)} do
        def op_of(code, mode, index)
          @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_#{module_name(arch).upcase}, mode)
          cs.decomposer = true
          cs.disasm(code, 0).first.operands[index]
        end

        #{types.map { |t| "it '#{t}' do\n  end" }.join("\n\n  ")}
      end
    RUBY
  end

  def write_file(filename, mod, res, rqr)
    puts "Writing #{filename}"
    IO.binwrite(File.join(@target_dir, filename), <<~TEMPLATE)
      # frozen_string_literal: true

      # THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

      #{rqr}

      module Crabstone
        module #{mod}
      #{res.lines.map { |l| l.strip.empty? ? "\n" : '    ' + l }.join}
        end
      end
    TEMPLATE
  end

  gen_const
  gen_arch
  write_dotversion

  Rake::Task['rubocop:auto_correct'].invoke
end
