# frozen_string_literal: true

require 'ffi'

require_relative 'detail'

module Crabstone
  module Binding
    class Instruction < FFI::ManagedStruct
      layout(
        :id, :uint,
        :address, :ulong_long,
        :size, :uint16,
        :bytes, [:uchar, 16],
        :mnemonic, [:char, 32],
        :op_str, [:char, 160],
        :detail, Detail.by_ref
      )
    end
  end
end
