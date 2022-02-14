# frozen_string_literal: true

require 'set'

module Crabstone
  # Module for arch/<version>/<arch>_const.rb to extend.
  module Register
    # @param [Integer, String, Symbol] reg
    # @return [Integer]
    def register(reg)
      return reg if value?(reg)

      dict[reg.to_s.upcase] || invalid
    end

    private

    def dict
      return @dict if defined?(@dict)

      keys = constants.select { |k| k.to_s.start_with?('REG_') }
      @dict = keys.map { |k| [k.to_s[4..], const_get(k)] }.to_h.freeze
    end

    def value?(val)
      @val_set ||= Set.new(dict.values)
      @val_set.member?(val)
    end

    def invalid
      dict['INVALID']
    end
  end
end
