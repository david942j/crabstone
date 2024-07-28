# frozen_string_literal: true

require 'fileutils'

require 'versionomy'

require_relative 'helper'

module Generate
  class Generator
    include Generate::Helper

    def initialize(path_to_capstone, version_str, target_dir)
      @cs_path = File.expand_path(path_to_capstone)
      @version = Versionomy.parse(version_str)
      @target_dir = File.join(Dir.pwd, target_dir, @version.major.to_s)

      FileUtils.mkdir_p(@target_dir)
    end

    def write_dotversion
      File.open(File.join(@target_dir, '.version'), 'w') do |f|
        f.puts @version
      end
    end

    private

    def cs_path(sub = '')
      File.join(@cs_path, sub)
    end

    def glob(pattern, &block)
      Dir.glob(cs_path(pattern), &block)
    end

    def write_file(filename, rqr, mod, res)
      puts "Writing #{filename}"
      File.binwrite(File.join(@target_dir, filename), <<~TEMPLATE)
        # frozen_string_literal: true

        # THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

        #{rqr.strip}

        module Crabstone
          module #{mod}
        #{res.strip.lines.map { |l| l.strip.empty? ? "\n" : "    #{l}" }.join}
          end
        end
      TEMPLATE
    end
  end
end
