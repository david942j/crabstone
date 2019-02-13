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

    def glob(pattern, &block)
      Dir.glob(File.join(@cs_path, pattern), &block)
    end

    def write_dotversion
      File.open(File.join(@target_dir, '.version'), 'w') do |f|
        f.puts @version
      end
    end
  end
end
