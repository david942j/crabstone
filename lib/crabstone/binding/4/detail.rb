# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'ffi'

require 'crabstone/arch'

module Crabstone
  module Binding
    class Architecture < FFI::Union
      layout(
        :arm, ARM::Instruction,
        :arm64, ARM64::Instruction,
        :evm, EVM::Instruction,
        :m680x, M680X::Instruction,
        :m68k, M68K::Instruction,
        :mips, MIPS::Instruction,
        :ppc, PPC::Instruction,
        :sparc, Sparc::Instruction,
        :sysz, SysZ::Instruction,
        :tms320c64x, TMS320C64X::Instruction,
        :x86, X86::Instruction,
        :xcore, XCore::Instruction
      )
    end

    class Detail < FFI::Struct
      layout(
        :regs_read, [:uint16, 12],
        :regs_read_count, :uint8,
        :regs_write, [:uint16, 20],
        :regs_write_count, :uint8,
        :groups, [:uint8, 8],
        :groups_count, :uint8,
        :arch, Architecture
      )
    end
  end
end
