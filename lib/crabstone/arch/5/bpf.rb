# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'bpf_const'

module Crabstone
  module BPF
    class OperandMemory < FFI::Struct
      layout(
        :base, :uint8,
        :disp, :int
      )
    end

    class OperandValue < FFI::Union
      layout(
        :reg, :uint8,
        :imm, :ulong,
        :off, :uint,
        :mem, OperandMemory,
        :mmem, :uint,
        :msh, :uint,
        :ext, :uint
      )
    end

    class Operand < FFI::Struct
      layout(
        :type, :uint,
        :value, OperandValue,
        :access, :uint8
      )

      include Crabstone::Extension::Operand

      def reg?
        self[:type] == OP_REG
      end

      def imm?
        self[:type] == OP_IMM
      end

      def off?
        self[:type] == OP_OFF
      end

      def mem?
        [
          OP_MEM,
          OP_MMEM
        ].include?(self[:type])
      end

      def mmem?
        self[:type] == OP_MMEM
      end

      def msh?
        self[:type] == OP_MSH
      end

      def ext?
        self[:type] == OP_EXT
      end
    end

    class Instruction < FFI::Struct
      layout(
        :op_count, :uint8,
        :operands, [Operand, 4]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
