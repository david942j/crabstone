# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch/extension'
require_relative 'evm_const'

module Crabstone
  module EVM
    class Instruction < FFI::Struct
      layout(
        :pop, :int8,
        :push, :int8,
        :fee, :uint
      )
    end
  end
end
