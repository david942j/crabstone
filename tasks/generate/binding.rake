# frozen_string_literal: true

require 'fileutils'

require 'versionomy'

require_relative 'helper'

namespace :generate do
  desc 'To auto-generate files under lib/crabstone/binding/'
  task :binding, :path_to_capstone, :version do |_t, args|
    @cs_path = File.expand_path(args.path_to_capstone)
    @version = Versionomy.parse(args.version)
    @target_dir = File.join(Dir.pwd, 'lib', 'crabstone', 'binding', @version.major.to_s)
    include Helper

    FileUtils.mkdir_p(@target_dir)

    def gen_detail
      arch_fields = glob('bindings/python/capstone/*_const.py').map do |file|
        arch = File.basename(file).sub('_const.py', '')
        "#{arch.to_sym.inspect}, #{module_name(arch)}::Instruction"
      end
      detail = parser.fetch_struct(:cs_detail)
      detail.fields.pop while detail.fields.last.type.to_s.start_with?('cs_')

      write_file('detail.rb', <<~RUBY)
        # frozen_string_literal: true

        # THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

        require 'ffi'

        require 'crabstone/arch'

        module Crabstone
          module Binding
            class Architecture < FFI::Union
              layout(
                #{arch_fields.sort.join(",\n        ")}
              )
            end

            class Detail < FFI::Struct
              layout(
                #{detail.fields.map(&:to_layout).join(",\n        ")},
                :arch, Architecture
              )
            end
          end
        end
      RUBY
    end

    def gen_instruction
      write_file('instruction.rb', <<~RUBY)
        # frozen_string_literal: true

        # THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

        require 'ffi'

        require_relative 'detail'

        module Crabstone
          module Binding
            class Instruction < FFI::ManagedStruct
              #{parser.fetch_struct(:cs_insn).to_layout.lines.join(' ' * 6).strip}
            end
          end
        end
      RUBY
    end

    def parser
      Helper::HParser.new do |config|
        config.include_path << File.join(@cs_path, 'include')
        config.file = File.join(@cs_path, 'include', @version.major >= 4 ? 'capstone' : '', 'capstone.h')
      end
    end

    def write_file(filename, content)
      puts "Writing #{filename}"
      IO.binwrite(File.join(@target_dir, filename), content)
    end

    gen_detail
    gen_instruction
    write_dotversion
  end
end
