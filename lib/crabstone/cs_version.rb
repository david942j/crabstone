# frozen_string_literal: true

require 'ffi'

require 'crabstone/version'

module Crabstone
  module_function

  # Since some constants/structures are different in different Capstone versions,
  # some scripts in Crabstone use this method to require the version-sensitive Ruby scripts.
  # @param [String] path_tpl
  # @return [Boolean]
  # @example
  #   version_require 'crabstone/binding/%v/structs'
  #   # equivalent to "require 'crabstone/binding/4/structs'" if Capstone is version 4.
  def version_require(path_tpl)
    version_compatitable!
    path = path_tpl.gsub('%v', cs_major_version.to_s)
    require path
  end

  # Get the major version of capstone library.
  #
  # @return [Integer]
  #   Returns the major version of Capstone.
  def cs_major_version
    cs_version.first
  end

  # @return [(Integer, Integer)]
  def cs_version
    return @cs_version if defined?(@cs_version)

    maj = FFI::MemoryPointer.new(:int)
    min = FFI::MemoryPointer.new(:int)
    Binding.cs_version(maj, min)
    @cs_version = [maj.read_int, min.read_int]
  end

  # Checks the cs_major is less or equal to Crabstone::VERSION.
  def version_compatitable!
    @version_compatitable ||=
      cs_major_version <= VERSION.split('.').first.to_i && cs_major_version >= 3
    maj, min = cs_version
    raise "FATAL: Crabstone v#{VERSION} doesn't support binding Capstone v#{maj}.#{min}" unless @version_compatitable
  end

  # @private
  module Binding
    extend FFI::Library
    ffi_lib ['capstone', 'libcapstone.so.4', 'libcapstone.so.3']

    attach_function :cs_version, %i[pointer pointer], :uint
  end
end
