# frozen_string_literal: true

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'ffi'

require_relative 'mips_const'

module Crabstone
  module MIPS
    class MemoryOperand < FFI::Struct
      layout(
        :base, :uint,
        :disp, :int64
      )
    end

    class OperandValue < FFI::Union
      layout(
        :reg, :uint,
        :imm, :long_long,
        :mem, MemoryOperand
      )
    end

    class Operand < FFI::Struct
      layout(
        :type, :uint,
        :value, OperandValue
      )

      def value
        if reg?
          self[:value][:reg]
        elsif imm?
          self[:value][:imm]
        elsif mem?
          self[:value][:mem]
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

      def valid?
        [OP_MEM, OP_IMM, OP_REG].include? self[:type]
      end
    end

    class Instruction < FFI::Struct
      layout(
        :op_count, :uint8,
        :operands, [Operand, 8]
      )

      def operands
        self[:operands].take_while { |op| op[:type].nonzero? }
      end
    end
  end
end
