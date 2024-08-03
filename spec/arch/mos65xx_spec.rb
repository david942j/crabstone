# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::MOS65XX' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_MOS65XX, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  before(:all) do
    skip 'MOS65XX not supported' unless Crabstone.const_defined?(:MOS65XX)
  end

  it 'reg' do
    # asl a
    op = op_of("\x0a", Crabstone::MODE_MOS65XX_6502, 0)
    expect(op.reg?).to be true
    expect(op.value).to be Crabstone::MOS65XX::REG_ACC
  end

  it 'imm' do
    # ora #0xff
    op = op_of("\x09\xff", Crabstone::MODE_MOS65XX_6502, 0)
    expect(op.imm?).to be true
    expect(op.value).to be 0xff
  end

  it 'mem' do
    # ora 0x1234
    op = op_of("\x0d\x34\x12", Crabstone::MODE_MOS65XX_6502, 0)
    expect(op.mem?).to be true
    expect(op.value).to be 0x1234
  end
end
