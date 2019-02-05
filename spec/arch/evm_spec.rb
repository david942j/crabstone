# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::EVM' do
  def inst_of(code)
    cs = Crabstone::Disassembler.new(Crabstone::ARCH_EVM, Crabstone::MODE_LITTLE_ENDIAN)
    cs.decomposer = true
    cs.disasm(code, 0).first
  end

  before(:all) do
    skip 'EVM not supported' unless Crabstone.const_defined?(:EVM)
  end

  it 'push' do
    inst = inst_of("\x60\x61")
    expect(inst[:push]).to be 1
    expect(inst[:fee]).to be 3
  end

  it 'pop' do
    inst = inst_of("\x50")
    expect(inst[:pop]).to be 1
    expect(inst[:fee]).to be 2
  end
end
