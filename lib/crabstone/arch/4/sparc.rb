# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

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
        :cc, :uint,
        :hint, :uint,
        :op_count, :uint8,
        :operands, [Operand, 4]
      )

      def operands
        self[:operands].take_while { |op| op[:type] != OP_INVALID }
      end
    end
  end
end
