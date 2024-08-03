# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'sparc_const'

module Crabstone
  module Sparc
    class OperandMemory < FFI::Struct
      layout(
        :base, :uint8,
        :index, :uint8,
        :disp, :int
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
        :cc, :uint,
        :hint, :uint,
        :op_count, :uint8,
        :operands, [Operand, 4]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
