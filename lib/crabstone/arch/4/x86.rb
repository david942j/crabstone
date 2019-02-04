# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

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

      def value
        OperandValue.members.find do |s|
          return self[:value][s] if __send__("#{s}?".to_sym)
        end
      end

      def reg?
        self[:type] == OP_REG
      end

      def imm?
        self[:type] == OP_IMM
      end

      def mem?
        self[:type] == OP_MEM
      end

      def valid?
        !value.nil?
      end
    end

    class Instruction < FFI::Struct
      layout(
        :modrm_offset, :uint8,
        :disp_offset, :uint8,
        :disp_size, :uint8,
        :imm_offset, :uint8,
        :imm_size, :uint8
      )

      def operands
        self[:operands].take_while { |op| op[:type] != OP_INVALID }
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
        :encoding, Instruction
      )
    end
  end
end
