require 'ffi'

require 'crabstone/arch/all'

module Crabstone
  module Binding
    extend FFI::Library
    ffi_lib ['capstone', 'libcapstone.so.3']

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

      def self.release(ptr)
        detail_ptr = ptr.+(Instruction.offset_of(:detail)).read_pointer
        Binding.free(detail_ptr)
        Binding.free(ptr)
      end
    end

    callback :skipdata_cb, %i[pointer size_t size_t pointer], :size_t

    class SkipdataConfig < FFI::Struct
      layout(
        :mnemonic, :pointer,
        :callback, :skipdata_cb,
        :unused, :pointer
      )
    end

    attach_function(
      :cs_disasm,
      %i[csh pointer size_t ulong_long size_t pointer],
      :size_t
    )
    attach_function :cs_close, [:pointer], :cs_err
    attach_function :cs_errno, [:csh], :cs_err
    attach_function :cs_group_name, %i[csh uint], :string
    attach_function :cs_insn_group, [:csh, Instruction, :uint], :bool
    attach_function :cs_insn_name, %i[csh uint], :string
    attach_function :cs_op_count, [:csh, Instruction, :uint], :cs_err
    attach_function :cs_open, %i[cs_arch cs_mode pointer], :cs_err
    attach_function :cs_option, %i[csh cs_opt_type cs_opt_value], :cs_err
    attach_function :cs_reg_name, %i[csh uint], :string
    attach_function :cs_reg_read, [:csh, Instruction, :uint], :bool
    attach_function :cs_reg_write, [:csh, Instruction, :uint], :bool
    attach_function :cs_strerror, [:cs_err], :string
    attach_function :cs_support, [:cs_arch], :bool
    attach_function :cs_version, %i[pointer pointer], :uint
    attach_function :memcpy, %i[pointer pointer size_t], :pointer
    attach_function :malloc, [:size_t], :pointer
    attach_function :free, [:pointer], :void
  end

  # This is a C engine build option, so we can set it here, not when we
  # instantiate a new Disassembler.
  DIET_MODE = Binding.cs_support SUPPORT_DIET
  # Diet mode means:
  # - No op_str or mnemonic in Instruction
  # - No regs_read, regs_write or groups ( even with detail on )
  # - No reg_name or insn_name id2str convenience functions
  # - detail mode CAN still be on - so the arch insn operands MAY be available
end
