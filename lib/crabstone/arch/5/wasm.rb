# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'wasm_const'

module Crabstone
  module WASM
    class BrTable < FFI::Struct
      layout(
        :length, :uint,
        :address, :ulong,
        :default_target, :uint
      )
    end

    class OperandValue < FFI::Union
      layout(
        :int7, :int8,
        :varuint32, :uint,
        :varuint64, :ulong,
        :uint32, :uint,
        :uint64, :ulong,
        :immediate, [:uint, 2],
        :brtable, BrTable
      )
    end

    class Operand < FFI::Struct
      layout(
        :type, :uint,
        :size, :uint,
        :value, OperandValue
      )

      include Crabstone::Extension::Operand

      def int7?
        self[:type] == OP_INT7
      end

      def varuint32?
        self[:type] == OP_VARUINT32
      end

      def varuint64?
        self[:type] == OP_VARUINT64
      end

      def uint32?
        [
          OP_VARUINT32,
          OP_UINT32
        ].include?(self[:type])
      end

      def uint64?
        [
          OP_VARUINT64,
          OP_UINT64
        ].include?(self[:type])
      end

      def brtable?
        self[:type] == OP_BRTABLE
      end
    end

    class Instruction < FFI::Struct
      layout(
        :op_count, :uint8,
        :operands, [Operand, 2]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
