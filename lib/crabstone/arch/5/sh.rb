# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'sh_const'

module Crabstone
  module SH
    class OperandMemory < FFI::Struct
      layout(
        :address, :uint,
        :reg, :uint,
        :disp, :uint
      )
    end

    class OperandDsp < FFI::Struct
      layout(
        :insn, :uint,
        :operand, [:uint, 2],
        :r, [:uint, 6],
        :cc, :uint,
        :imm, :uint8,
        :size, :int
      )
    end

    class OperandValue < FFI::Union
      layout(
        :imm, :long,
        :reg, :uint,
        :mem, OperandMemory,
        :dsp, OperandDsp
      )
    end

    class Operand < FFI::Struct
      layout(
        :type, :uint,
        :value, OperandValue
      )

      include Crabstone::Extension::Operand

      def reg?
        [
          OP_REG,
          OP_MEM_REG_IND,
          OP_MEM_REG_POST,
          OP_MEM_REG_PRE,
          OP_MEM_REG_DISP,
          OP_MEM_REG_R0,
          OP_DSP_REG_PRE,
          OP_DSP_REG_IND,
          OP_DSP_REG_POST,
          OP_DSP_REG_INDEX,
          OP_DSP_REG
        ].include?(self[:type])
      end

      def imm?
        [
          OP_IMM,
          OP_DSP_IMM
        ].include?(self[:type])
      end

      def mem?
        [
          OP_MEM,
          OP_MEM_INVALID,
          OP_MEM_REG_IND,
          OP_MEM_REG_POST,
          OP_MEM_REG_PRE,
          OP_MEM_REG_DISP,
          OP_MEM_REG_R0,
          OP_MEM_GBR_DISP,
          OP_MEM_GBR_R0,
          OP_MEM_PCR,
          OP_MEM_TBR_DISP
        ].include?(self[:type])
      end

      def mem_invalid?
        self[:type] == OP_MEM_INVALID
      end

      def mem_reg_ind?
        self[:type] == OP_MEM_REG_IND
      end

      def mem_reg_post?
        self[:type] == OP_MEM_REG_POST
      end

      def mem_reg_pre?
        self[:type] == OP_MEM_REG_PRE
      end

      def mem_reg_disp?
        self[:type] == OP_MEM_REG_DISP
      end

      def mem_reg_r0?
        self[:type] == OP_MEM_REG_R0
      end

      def mem_gbr_disp?
        self[:type] == OP_MEM_GBR_DISP
      end

      def mem_gbr_r0?
        self[:type] == OP_MEM_GBR_R0
      end

      def mem_pcr?
        self[:type] == OP_MEM_PCR
      end

      def mem_tbr_disp?
        self[:type] == OP_MEM_TBR_DISP
      end

      def dsp_invalid?
        self[:type] == OP_DSP_INVALID
      end

      def dsp_reg_pre?
        self[:type] == OP_DSP_REG_PRE
      end

      def dsp_reg_ind?
        [
          OP_DSP_REG_IND,
          OP_DSP_REG_INDEX
        ].include?(self[:type])
      end

      def dsp_reg_post?
        self[:type] == OP_DSP_REG_POST
      end

      def dsp_reg_index?
        self[:type] == OP_DSP_REG_INDEX
      end

      def dsp_reg?
        [
          OP_DSP_REG_PRE,
          OP_DSP_REG_IND,
          OP_DSP_REG_POST,
          OP_DSP_REG_INDEX,
          OP_DSP_REG
        ].include?(self[:type])
      end

      def dsp_imm?
        self[:type] == OP_DSP_IMM
      end
    end

    class Instruction < FFI::Struct
      layout(
        :insn, :uint,
        :size, :uint8,
        :op_count, :uint8,
        :operands, [Operand, 3]
      )

      include Crabstone::Extension::Instruction
    end
  end
end
