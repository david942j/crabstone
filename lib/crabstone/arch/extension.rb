# frozen_string_literal: true

module Crabstone
  # These modules is for +class Operand+ and +class Instruction+ to extend.
  # @private
  module Extension
    # For +class Operand+.
    module Operand
      def value
        self[:value].class.members.find do |s|
          return self[:value][s] if __send__("#{s}?".to_sym)
        end
      end

      def valid?
        !value.nil?
      end
    end

    # For +class Instruction+.
    module Instruction
      def operands
        self[:operands].take_while { |op| op[:type] != OP_INVALID }
      end
    end
  end
end
