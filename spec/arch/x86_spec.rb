# frozen_string_literal: true

require 'crabstone/disassembler'

describe Crabstone::X86 do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
  end

  it 'imm' do
  end

  it 'mem' do
  end

  it 'fp' do
  end
end
