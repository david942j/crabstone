# frozen_string_literal: true

require 'crabstone/disassembler'

describe Crabstone::XCore do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_XCore, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
  end

  it 'imm' do
  end

  it 'mem' do
  end
end
