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

  def gen_arch
    glob('bindings/python/capstone/*.py') do |file|
      next if file.end_with?('_const.py', '__init__.py')

      py_mod = File.basename(file).sub('.py', '')
      arch = py_mod == 'systemz' ? 'sysz' : py_mod
      mod = module_name(arch)
      write_file(arch + '.rb', mod, Helper::Python.new(py_mod).to_layout.join("\n"), <<~REQUIRE)
        require 'ffi'

        require_relative '#{arch}_const'
      REQUIRE
    end
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
    end
  end

  def write_file(filename, mod, res, rqr)
    puts "Writing #{filename}"
    IO.binwrite(File.join(@target_dir, filename), <<~TEMPLATE)
      # frozen_string_literal: true

      # THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

      #{rqr}

      module Crabstone
        module #{mod}
          #{res.lines.join('    ')}
        end
      end
    TEMPLATE
  end

  gen_arch
  gen_const
  write_dotversion

  Rake::Task['rubocop:auto_correct'].invoke
end
