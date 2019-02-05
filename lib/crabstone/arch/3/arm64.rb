# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'arm64_const'

module Crabstone
  module ARM64
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
        :disp, :int
      )
    end

    class OperandValue < FFI::Union
      layout(
        :reg, :uint,
        :imm, :long,
        :fp, :double,
        :mem, OperandMemory,
        :pstate, :int,
        :sys, :uint,
        :prefetch, :int,
        :barrier, :int
      )
    end

    class Operand < FFI::Struct
      layout(
        :vector_index, :int,
        :vas, :int,
        :vess, :int,
        :shift, OperandShift,
        :ext, :uint,
        :type, :uint,
        :value, OperandValue
      )
      def shift?
        self[:shift][:type] != SFT_INVALID
      end

      def ext?
        self[:ext] != EXT_INVALID
      end

      include Crabstone::Extension::Operand

      def reg?
        [
          OP_REG,
          OP_REG_MRS,
          OP_REG_MSR
        ].include?(self[:type])
      end

      def imm?
        [
          OP_IMM,
          OP_CIMM
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

      def reg_mrs?
        self[:type] == OP_REG_MRS
      end

      def reg_msr?
        self[:type] == OP_REG_MSR
      end

      def pstate?
        self[:type] == OP_PSTATE
      end

      def sys?
        self[:type] == OP_SYS
      end

      def prefetch?
        self[:type] == OP_PREFETCH
      end

      def barrier?
        self[:type] == OP_BARRIER
      end
    end

    class Instruction < FFI::Struct
      layout(
        :cc, :uint,
        :update_flags, :bool,
        :writeback, :bool,
        :op_count, :uint8,
        :operands, [Operand, 8]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
