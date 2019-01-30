# frozen_string_literal: true

require 'ffi'

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
    # TODO: raise proper error if version not supported
    path = path_tpl.gsub('%v', cs_major_version.to_s)
    require path
  end

  # Get the major version of capstone library.
  #
  # @return [Integer]
  #   Returns the major version of Capstone.
  def cs_major_version
    return @cs_major_version if defined?(@cs_major_version)

    maj = FFI::MemoryPointer.new(:int)
    min = FFI::MemoryPointer.new(:int)
    Binding.cs_version(maj, min)
    @cs_major_version = maj.read_int
  end

  # @private
  module Binding
    extend FFI::Library
    ffi_lib ['capstone', 'libcapstone.so.4', 'libcapstone.so.3']

    attach_function :cs_version, %i[pointer pointer], :uint
  end
end
