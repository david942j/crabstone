# frozen_string_literal: true

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'ffi'

require_relative 'arm64_const'

module Crabstone
  module ARM64
    class OperandShift < FFI::Struct
      layout(
        :type, :uint,
        :value, :uint
      )
    end

    class MemoryOperand < FFI::Struct
      layout(
        :base, :uint,
        :index, :uint,
        :disp, :int32
      )
    end

    class OperandValue < FFI::Union
      layout(
        :reg, :uint,
        :imm, :int64,
        :fp, :double,
        :mem, MemoryOperand,
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

      def value
        val = self[:value]
        if reg?            # Register operand.
          val[:reg]
        elsif imm?         # Immediate operand.
          val[:imm]
        elsif fp?          # Floating-Point immediate operand.
          val[:fp]
        elsif mem?         # Memory operand
          val[:mem]
        elsif pstate?      # PState operand.
          val[:pstate]
        elsif sys?         # SYS operand for IC/DC/AT/TLBI instructions.
          val[:sys]
        elsif prefetch?    # Prefetch operand (PRFM).
          val[:prefetch]
        elsif barrier?     # Memory barrier operand (ISB/DMB/DSB instructions).
          val[:barrier]
        end
      end

      def shift?
        self[:shift][:type] != SFT_INVALID
      end

      def ext?
        self[:ext] != EXT_INVALID
      end

      def reg?
        [OP_REG, OP_REG_MRS, OP_REG_MSR].include?(self[:type])
      end

      def imm?
        [OP_IMM, OP_CIMM].include?(self[:type])
      end

      def cimm?
        self[:type] == OP_CIMM
      end

      def mem?
        self[:type] == OP_MEM
      end

      def fp?
        self[:type] == OP_FP
      end

      def pstate?
        self[:type] == OP_PSTATE
      end

      def reg_msr?
        self[:type] == OP_REG_MSR
      end

      def reg_mrs?
        self[:type] == OP_REG_MRS
      end

      def barrier?
        self[:type] == OP_BARRIER
      end

      def sys?
        self[:type] == OP_SYS
      end

      def prefetch?
        self[:type] == OP_PREFETCH
      end

      def valid?
        [
          OP_REG,
          OP_CIMM,
          OP_IMM,
          OP_FP,
          OP_MEM,
          OP_REG_MRS,
          OP_REG_MSR,
          OP_PSTATE,
          OP_SYS,
          OP_PREFETCH,
          OP_BARRIER
        ].include? self[:type]
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

      def operands
        self[:operands].take_while { |op| op[:type].nonzero? }
      end
    end
  end
end
