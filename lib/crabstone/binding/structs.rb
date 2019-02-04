# frozen_string_literal: true

require 'ffi'

require 'crabstone/cs_version'
Crabstone.version_require 'crabstone/binding/%v/instruction'

module Crabstone
  module Binding
    # This is because JRuby FFI on x64 Windows thinks size_t is 32 bit
    typedef(FFI::Platform::ADDRESS_SIZE == 32 ? :ulong : :ulong_long, :size_t)

    # If one day these definitions change, move them to <version>/ dir.

    typedef :size_t, :csh
    typedef :size_t, :cs_opt_value
    typedef :uint, :cs_opt_type
    typedef :uint, :cs_err
    typedef :uint, :cs_arch
    typedef :uint, :cs_mode

    callback :skipdata_cb, %i[pointer size_t size_t pointer], :size_t

    class SkipdataConfig < FFI::Struct
      layout(
        :mnemonic, :pointer,
        :callback, :skipdata_cb,
        :unused, :pointer
      )
    end
  end
end
