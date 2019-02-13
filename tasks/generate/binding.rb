# frozen_string_literal: true

require_relative 'generator'
require_relative 'hparser'

module Generate
  class Binding < Generate::Generator
    def gen_detail
      arch_fields = glob('bindings/python/capstone/*_const.py').map do |file|
        arch = File.basename(file).sub('_const.py', '')
        "#{arch.to_sym.inspect}, #{module_name(arch)}::Instruction"
      end
      detail = parser.fetch_struct(:cs_detail)
      detail.fields.pop while detail.fields.last.type.to_s.start_with?('cs_')

      content = <<~RUBY
        class Architecture < FFI::Union
          layout(
            #{arch_fields.sort.join(",\n    ")}
          )
        end

        class Detail < FFI::Struct
          layout(
            #{detail.fields.map(&:to_layout).join(",\n    ")},
            :arch, Architecture
          )
        end
      RUBY
      # XXX: someday +detail+ might not end with Architecture.

      write_file('detail.rb', <<~REQUIRE, 'Binding', content)
        require 'ffi'

        require 'crabstone/arch'
      REQUIRE
    end

    def gen_instruction
      content = <<~RUBY
        class Instruction < FFI::ManagedStruct
          #{parser.fetch_struct(:cs_insn).to_layout.lines.join(' ' * 2).strip}
        end
      RUBY
      write_file('instruction.rb', <<~REQUIRE, 'Binding', content)
        require 'ffi'

        require_relative 'detail'
      REQUIRE
    end

    private

    def parser
      HParser.new do |config|
        config.include_path << File.join(@cs_path, 'include')
        config.file = File.join(@cs_path, 'include', @version.major >= 4 ? 'capstone' : '', 'capstone.h')
      end
    end
  end
end
