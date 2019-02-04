# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::M680X' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_M680X, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'register' do
  end

  it 'immediate' do
  end

  it 'indexed' do
  end

  it 'extended' do
  end

  it 'direct' do
  end

  it 'relative' do
  end

  it 'constant' do
  end
end
