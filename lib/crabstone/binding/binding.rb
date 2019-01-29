require 'crabstone/binding/structs'

# TODO: This file should require proper files according to the
# return value of cs_version.
module Crabstone
  module Binding
    class Instruction < FFI::ManagedStruct
      def self.release(ptr)
        detail_ptr = ptr.+(Instruction.offset_of(:detail)).read_pointer
        Binding.free(detail_ptr)
        Binding.free(ptr)
      end
    end

    # These APIs still might be changed in a new Capstone version.
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
  DIET_MODE = Binding.cs_support(SUPPORT_DIET)
  # Diet mode means:
  # - No op_str or mnemonic in Instruction
  # - No regs_read, regs_write or groups ( even with detail on )
  # - No reg_name or insn_name id2str convenience functions
  # - detail mode CAN still be on - so the arch insn operands MAY be available
end
