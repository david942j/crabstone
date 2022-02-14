# frozen_string_literal: true

require 'crabstone/constants'
require 'crabstone/binding/structs'

module Crabstone
  module Binding
    class Instruction < FFI::ManagedStruct
      def self.release(obj)
        return if @freed

        ptr = case obj
              when FFI::Pointer
                obj
              else
                obj.pointer
              end
        @freed = true
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
    # Already defined in cs_version.rb
    # attach_function :cs_version, %i[pointer pointer], :uint
    attach_function :memcpy, %i[pointer pointer size_t], :pointer
    attach_function :malloc, [:size_t], :pointer
    attach_function :free, [:pointer], :void

    # Wrap to prevent function not found in elder Capstone.
    def self.safe_attach(*args)
      attach_function(*args)
    rescue FFI::NotFoundError
    end

    # New APIs since Capstone 4.
    safe_attach :cs_regs_access, [:csh, Instruction, :pointer, :pointer, :pointer, :pointer], :cs_err
  end

  # This is a C engine build option, so we can set it here, not when we
  # instantiate a new Disassembler.
  # Diet mode means:
  # - No op_str or mnemonic in Instruction
  # - No regs_read, regs_write or groups ( even with detail on )
  # - No reg_name or insn_name id2str convenience functions
  # - detail mode CAN still be on - so the arch insn operands MAY be available
  DIET_MODE = Binding.cs_support(SUPPORT_DIET)
end
