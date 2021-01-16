# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'x86_const'

module Crabstone
  module X86
    class OperandMemory < FFI::Struct
      layout(
        :segment, :uint,
        :base, :uint,
        :index, :uint,
        :scale, :int,
        :disp, :long
      )
    end

    class OperandValue < FFI::Union
      layout(
        :reg, :uint,
        :imm, :long,
        :mem, OperandMemory
      )
    end

    class Operand < FFI::Struct
      layout(
        :type, :uint,
        :value, OperandValue,
        :size, :uint8,
        :access, :uint8,
        :avx_bcast, :uint,
        :avx_zero_opmask, :bool
      )

      include Crabstone::Extension::Operand

      def reg?
        self[:type] == OP_REG
      end

      def imm?
        self[:type] == OP_IMM
      end

      def mem?
        self[:type] == OP_MEM
      end
    end

    class Encoding < FFI::Struct
      layout(
        :modrm_offset, :uint8,
        :disp_offset, :uint8,
        :disp_size, :uint8,
        :imm_offset, :uint8,
        :imm_size, :uint8
      )
    end

    class Instruction < FFI::Struct
      layout(
        :prefix, [:uint8, 4],
        :opcode, [:uint8, 4],
        :rex, :uint8,
        :addr_size, :uint8,
        :modrm, :uint8,
        :sib, :uint8,
        :disp, :long,
        :sib_index, :uint,
        :sib_scale, :int8,
        :sib_base, :uint,
        :xop_cc, :uint,
        :sse_cc, :uint,
        :avx_cc, :uint,
        :avx_sae, :bool,
        :avx_rm, :uint,
        :eflags, :ulong,
        :op_count, :uint8,
        :operands, [Operand, 8],
        :encoding, Encoding
      )

      include Crabstone::Extension::Instruction
    end
  end
end
