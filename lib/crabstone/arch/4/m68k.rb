# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require_relative 'm68k_const'

module Crabstone
  module M68K
    class OperandRegPair < FFI::Struct
      layout(
        :reg_0, :uint,
        :reg_1, :uint
      )
    end

    class OperandValue < FFI::Union
      layout(
        :imm, :long,
        :dimm, :double,
        :simm, :float,
        :reg, :uint,
        :reg_pair, OperandRegPair
      )
    end

    class OperandMemory < FFI::Struct
      layout(
        :base_reg, :uint,
        :index_reg, :uint,
        :in_base_reg, :uint,
        :in_disp, :uint,
        :out_disp, :uint,
        :disp, :short,
        :scale, :uint8,
        :bitfield, :uint8,
        :width, :uint8,
        :offset, :uint8,
        :index_size, :uint8
      )
    end

    class OperandBrDisp < FFI::Struct
      layout(
        :disp, :int,
        :disp_size, :uint8
      )
    end

    class Operand < FFI::Struct
      layout(
        :value, OperandValue,
        :mem, OperandMemory,
        :br_disp, OperandBrDisp,
        :register_bits, :uint,
        :type, :uint,
        :address_mode, :uint
      )

      def value
        OperandValue.members.find do |s|
          return self[:value][s] if __send__("#{s}?".to_sym)
        end
      end

      def reg?
        [
          OP_REG,
          OP_REG_BITS,
          OP_REG_PAIR
        ].include?(self[:type])
      end

      def imm?
        self[:type] == OP_IMM
      end

      def mem?
        self[:type] == OP_MEM
      end

      def fp_single?
        self[:type] == OP_FP_SINGLE
      end

      def fp_double?
        self[:type] == OP_FP_DOUBLE
      end

      def reg_bits?
        self[:type] == OP_REG_BITS
      end

      def reg_pair?
        self[:type] == OP_REG_PAIR
      end

      def br_disp?
        [
          OP_BR_DISP,
          OP_BR_DISP_SIZE_INVALID,
          OP_BR_DISP_SIZE_BYTE,
          OP_BR_DISP_SIZE_WORD,
          OP_BR_DISP_SIZE_LONG
        ].include?(self[:type])
      end

      def br_disp_size_invalid?
        self[:type] == OP_BR_DISP_SIZE_INVALID
      end

      def br_disp_size_byte?
        self[:type] == OP_BR_DISP_SIZE_BYTE
      end

      def br_disp_size_word?
        self[:type] == OP_BR_DISP_SIZE_WORD
      end

      def br_disp_size_long?
        self[:type] == OP_BR_DISP_SIZE_LONG
      end

      def valid?
        !value.nil?
      end
    end

    class OperandSize < FFI::Struct
      layout(
        :type, :uint,
        :size, :uint
      )
    end

    class Instruction < FFI::Struct
      layout(
        :operands, [Operand, 4],
        :op_size, OperandSize,
        :op_count, :uint8
      )

      def operands
        self[:operands].take_while { |op| op[:type] != OP_INVALID }
      end
    end
  end
end
