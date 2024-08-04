# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'sh_const'

module Crabstone
  module SH
    class OperandMemory < FFI::Struct
      layout(
        :address, :uint,
        :reg, :uint,
        :disp, :uint
      )
    end

    class OperandDsp < FFI::Struct
      layout(
        :insn, :uint,
        :operand, [:uint, 2],
        :r, [:uint, 6],
        :cc, :uint,
        :imm, :uint8,
        :size, :int
      )
    end

    class OperandValue < FFI::Union
      layout(
        :imm, :long,
        :reg, :uint,
        :mem, OperandMemory,
        :dsp, OperandDsp
      )
    end

    class Operand < FFI::Struct
      layout(
        :type, :uint,
        :value, OperandValue
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

    class Instruction < FFI::Struct
      layout(
        :insn, :uint,
        :size, :uint8,
        :op_count, :uint8,
        :operands, [Operand, 3]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
