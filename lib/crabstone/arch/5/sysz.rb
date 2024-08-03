# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'sysz_const'

module Crabstone
  module SysZ
    class OperandMemory < FFI::Struct
      layout(
        :base, :uint8,
        :index, :uint8,
        :length, :ulong,
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
        :op_count, :uint8,
        :operands, [Operand, 6]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
