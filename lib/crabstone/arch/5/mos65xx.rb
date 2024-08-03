# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'mos65xx_const'

module Crabstone
  module MOS65XX
    class OperandValue < FFI::Union
      layout(
        :reg, :uint,
        :imm, :ushort,
        :mem, :uint
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
        :am, :uint,
        :modifies_flags, :uint8,
        :op_count, :uint8,
        :operands, [Operand, 3]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
