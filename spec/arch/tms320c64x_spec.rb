# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::TMS320C64X' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_TMS320C64X, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
  end

  it 'imm' do
  end

  it 'mem' do
  end

  it 'regpair' do
  end
end
