# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require_relative 'detail'

module Crabstone
  module Binding
    class Instruction < FFI::ManagedStruct
      layout(
        :id, :uint32,
        :address, :uint64,
        :size, :uint16,
        :bytes, [:uint8, 24],
        :mnemonic, [:char, 32],
        :op_str, [:char, 160],
        :detail, Detail.by_ref
      )
    end
  end
end
