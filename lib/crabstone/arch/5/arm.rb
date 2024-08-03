# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'arm_const'

module Crabstone
  module ARM
    class OperandShift < FFI::Struct
      layout(
        :type, :uint,
        :value, :uint
      )
    end

    class OperandMemory < FFI::Struct
      layout(
        :base, :uint,
        :index, :uint,
        :scale, :int,
        :disp, :int,
        :lshift, :int
      )
    end

    class OperandValue < FFI::Union
      layout(
        :reg, :uint,
        :imm, :int,
        :fp, :double,
        :mem, OperandMemory,
        :setend, :int
      )
    end

    class Operand < FFI::Struct
      layout(
        :vector_index, :int,
        :shift, OperandShift,
        :type, :uint,
        :value, OperandValue,
        :subtracted, :bool,
        :access, :uint8,
        :neon_lane, :int8
      )

      include Crabstone::Extension::Operand

      def reg?
        [
          OP_REG,
          OP_SYSREG
        ].include?(self[:type])
      end

      def imm?
        [
          OP_IMM,
          OP_CIMM,
          OP_PIMM
        ].include?(self[:type])
      end

      def mem?
        self[:type] == OP_MEM
      end

      def fp?
        self[:type] == OP_FP
      end

      def cimm?
        self[:type] == OP_CIMM
      end

      def pimm?
        self[:type] == OP_PIMM
      end

      def setend?
        self[:type] == OP_SETEND
      end

      def sysreg?
        self[:type] == OP_SYSREG
      end
    end

    class Instruction < FFI::Struct
      layout(
        :usermode, :bool,
        :vector_size, :int,
        :vector_data, :int,
        :cps_mode, :int,
        :cps_flag, :int,
        :cc, :uint,
        :update_flags, :bool,
        :writeback, :bool,
        :post_index, :bool,
        :mem_barrier, :int,
        :op_count, :uint8,
        :operands, [Operand, 36]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
