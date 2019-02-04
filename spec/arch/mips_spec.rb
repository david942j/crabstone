# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::MIPS' do
  def op_of(code, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_MIPS, Crabstone::MODE_MIPS32)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
    # lw v0, 16(sp)
    op = op_of("\x10\x00\xa2\x8f", 0)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'v0'
  end

  it 'imm' do
    # ori     t1,a2,0x4567
    op = op_of("\x67\x45\xc9\x34", 2)
    expect(op.imm?).to be true
    expect(op.value).to be 0x4567
  end

  it 'mem' do
    # lw v0, 16(sp)
    op = op_of("\x10\x00\xa2\x8f", 1)
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base])).to eq 'sp'
    expect(op.value[:disp]).to be 16
  end
end
