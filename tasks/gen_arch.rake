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

  # TODO: This is hard..
  def gen_arch; end

  # Simply use values generated under capstone/bindings/python.
  def gen_const
    glob('bindings/python/capstone/*_const.py') do |file|
      arch = File.basename(file).sub('_const.py', '')
      res = File.foreach(file).map do |line|
        next '' if line.strip.start_with?('#')

        line.strip.empty? ? "\n" : ' ' * 4 + line.gsub("#{arch.upcase}_", '')
      end.join
      res.gsub!(/\n{3,}/, "\n\n") # Remove more than two empty lines
      res << "\n    extend Register"
      write_file("#{arch}_const.rb", module_name(arch), res.strip)
    end
  end

  def header
    <<~HEADER
      # frozen_string_literal: true

      # Library by Nguyen Anh Quynh
      # Original binding by Nguyen Anh Quynh and Tan Sheng Di
      # Additional binding work by Ben Nagy
      # Rewrite by david942j
      # (c) 2013 COSEINC. All Rights Reserved.

      # THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!
    HEADER
  end

  def write_file(filename, mod, res)
    puts "Writing #{filename}"
    IO.binwrite(File.join(@target_dir, filename), <<~TEMPLATE)
      #{header}
      require 'crabstone/arch/register'

      module Crabstone
        module #{mod}
          #{res}
        end
      end
    TEMPLATE
  end

  def write_dotversion
    File.open(File.join(@target_dir, '.version'), 'w') do |f|
      f.puts @version
    end
  end

  gen_arch
  gen_const
  write_dotversion

  Rake::Task['rubocop:auto_correct'].invoke
end
