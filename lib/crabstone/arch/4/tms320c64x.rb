# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require_relative 'tms320c64x_const'

module Crabstone
  module TMS320C64X
    class OperandMemory < FFI::Struct
      layout(
        :base, :int,
        :disp, :int,
        :unit, :int,
        :scaled, :int,
        :disptype, :int,
        :direction, :int,
        :modify, :int
      )
    end

    class OperandValue < FFI::Union
      layout(
        :reg, :uint,
        :imm, :int,
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
        [
          OP_REG,
          OP_REGPAIR
        ].include?(self[:type])
      end

      def imm?
        self[:type] == OP_IMM
      end

      def mem?
        self[:type] == OP_MEM
      end

      def regpair?
        self[:type] == OP_REGPAIR
      end

      def valid?
        !value.nil?
      end
    end

    class Condition < FFI::Struct
      layout(
        :reg, :uint,
        :zero, :uint
      )
    end

    class FunctionalUnit < FFI::Struct
      layout(
        :unit, :uint,
        :side, :uint,
        :crosspath, :uint
      )
    end

    class Instruction < FFI::Struct
      layout(
        :op_count, :uint8,
        :operands, [Operand, 8],
        :condition, Condition,
        :funit, FunctionalUnit,
        :parallel, :uint
      )

      def operands
        self[:operands].take_while { |op| op[:type] != OP_INVALID }
      end
    end
  end
end
