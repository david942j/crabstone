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
        :fp, :double,
        :mem, OperandMemory
      )
    end

    class Operand < FFI::Struct
      layout(
        :type, :uint,
        :value, OperandValue,
        :size, :uint8,
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

      def fp?
        self[:type] == OP_FP
      end
    end

    class Instruction < FFI::Struct
      layout(
        :prefix, [:uint8, 4],
        :opcode, [:uint8, 4],
        :rex, :uint8,
        :addr_size, :uint8,
        :modrm, :uint8,
        :sib, :uint8,
        :disp, :int,
        :sib_index, :uint,
        :sib_scale, :int8,
        :sib_base, :uint,
        :sse_cc, :uint,
        :avx_cc, :uint,
        :avx_sae, :bool,
        :avx_rm, :uint,
        :op_count, :uint8,
        :operands, [Operand, 8]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
