# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
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

      include Crabstone::Extension::Operand

      # Use Extension::Operand#value first
      alias super_value value

      def value
        super_value || if mem?
                         self[:mem]
                       elsif br_disp?
                         self[:br_disp]
                       elsif reg_bits?
                         self[:register_bits]
                       end
      end

      def reg?
        self[:type] == OP_REG
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
      alias simm? fp_single?

      def fp_double?
        self[:type] == OP_FP_DOUBLE
      end
      alias dimm? fp_double?

      def reg_bits?
        self[:type] == OP_REG_BITS
      end

      def reg_pair?
        self[:type] == OP_REG_PAIR
      end

      def br_disp?
        self[:type] == OP_BR_DISP
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

      include Crabstone::Extension::Instruction
    end
  end
end
