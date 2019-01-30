require 'crabstone/arch'

# TODO: This file will be an auto-genreated one.
module Crabstone
  module Binding
    # This is because JRuby FFI on x64 Windows thinks size_t is 32 bit
    case FFI::Platform::ADDRESS_SIZE
    when 64
      typedef :ulong_long, :size_t
    when 32
      typedef :ulong, :size_t
    else
      raise 'Unsupported native address size'
    end

    typedef :size_t, :csh
    typedef :size_t, :cs_opt_value
    typedef :uint, :cs_opt_type
    typedef :uint, :cs_err
    typedef :uint, :cs_arch
    typedef :uint, :cs_mode

    class Architecture < FFI::Union
      layout(
        :arm, ARM::Instruction,
        :arm64, ARM64::Instruction,
        :mips, MIPS::Instruction,
        :x86, X86::Instruction,
        :ppc, PPC::Instruction,
        :sparc, Sparc::Instruction,
        :sysz, SysZ::Instruction,
        :xcore, XCore::Instruction
      )
    end

    class Detail < FFI::Struct
      layout(
        :regs_read, [:uint8, 12],
        :regs_read_count, :uint8,
        :regs_write, [:uint8, 20],
        :regs_write_count, :uint8,
        :groups, [:uint8, 8],
        :groups_count, :uint8,
        :arch, Architecture
      )
    end

    class Instruction < FFI::ManagedStruct
      layout(
        :id, :uint,
        :address, :ulong_long,
        :size, :uint16,
        :bytes, [:uchar, 16],
        :mnemonic, [:char, 32],
        :op_str, [:char, 160],
        :detail, Detail.by_ref
      )
    end

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
