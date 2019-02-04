# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require_relative 'ppc_const'

module Crabstone
  module PPC
    class OperandMemory < FFI::Struct
      layout(
        :base, :uint,
        :disp, :int
      )
    end

    class OperandCrx < FFI::Struct
      layout(
        :scale, :uint,
        :reg, :uint,
        :cond, :uint
      )
    end

    class OperandValue < FFI::Union
      layout(
        :reg, :uint,
        :imm, :long,
        :mem, OperandMemory,
        :crx, OperandCrx
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

      def crx?
        self[:type] == OP_CRX
      end

      def valid?
        !value.nil?
      end
    end

    class Instruction < FFI::Struct
      layout(
        :bc, :uint,
        :bh, :uint,
        :update_cr0, :bool,
        :op_count, :uint8,
        :operands, [Operand, 8]
      )

      def operands
        self[:operands].take_while { |op| op[:type] != OP_INVALID }
      end
    end
  end
end
