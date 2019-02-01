# frozen_string_literal: true

require 'fileutils'

require 'versionomy'

require_relative 'helper'

desc 'To auto-generate files under lib/crabstone/binding/'
task :gen_binding, :path_to_capstone, :version do |_t, args|
  next if ENV['CI']

  @cs_path = File.expand_path(args.path_to_capstone)
  @version = Versionomy.parse(args.version)
  @target_dir = File.join(__dir__, '..', 'lib', 'crabstone', 'binding', @version.major.to_s)

  FileUtils.mkdir_p(@target_dir)

  def gen_detail; end

  def gen_instruction
    parser = Helper::HParser.new do |config|
      config.include_path << File.join(@cs_path, 'include')
      config.file = File.join(@cs_path, 'include', 'capstone.h')
    end
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

  def write_file(filename, content)
    puts "Writing #{filename}"
    IO.binwrite(File.join(@target_dir, filename), content)
  end

  def write_dotversion
    File.open(File.join(@target_dir, '.version'), 'w') do |f|
      f.puts @version
    end
  end

  gen_detail
  gen_instruction
  write_dotversion

  Rake::Task['rubocop:auto_correct'].invoke
end
