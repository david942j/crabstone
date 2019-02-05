# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'm680x_const'

module Crabstone
  module M680X
    class OperandIdx < FFI::Struct
      layout(
        :base_reg, :uint,
        :offset_reg, :uint,
        :offset, :short,
        :offset_addr, :ushort,
        :offset_bits, :uint8,
        :inc_dec, :int8,
        :flags, :uint8
      )
    end

    class OperandRel < FFI::Struct
      layout(
        :address, :ushort,
        :offset, :short
      )
    end

    class OperandExt < FFI::Struct
      layout(
        :address, :ushort,
        :indirect, :bool
      )
    end

    class OperandValue < FFI::Union
      layout(
        :imm, :int,
        :reg, :uint,
        :idx, OperandIdx,
        :rel, OperandRel,
        :ext, OperandExt,
        :direct_addr, :uint8,
        :const_val, :uint8
      )
    end

    class Operand < FFI::Struct
      layout(
        :type, :uint,
        :value, OperandValue,
        :size, :uint8,
        :access, :uint8
      )

      include Crabstone::Extension::Operand

      def register?
        self[:type] == OP_REGISTER
      end

      def immediate?
        self[:type] == OP_IMMEDIATE
      end

      def indexed?
        self[:type] == OP_INDEXED
      end

      def extended?
        self[:type] == OP_EXTENDED
      end

      def direct?
        self[:type] == OP_DIRECT
      end

      def relative?
        self[:type] == OP_RELATIVE
      end

      def constant?
        self[:type] == OP_CONSTANT
      end
    end

    class Instruction < FFI::Struct
      layout(
        :flags, :uint8,
        :op_count, :uint8,
        :operands, [Operand, 9]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
