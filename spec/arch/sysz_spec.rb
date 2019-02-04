# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::SysZ' do
  def op_of(code, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_SYSZ, Crabstone::MODE_BIG_ENDIAN)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
    # adb f0, 0x17
    op = op_of("\xed\x00\x00\x17\x00\x1a", 0)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'f0'
  end

  it 'imm' do
    # adb f0, 0x17
    op = op_of("\xed\x00\x00\x17\x00\x1a", 1)
    expect(op.imm?).to be true
    expect(op.value).to be 0x17
  end

  it 'mem' do
    # xiy 0x7ffff(%r15), 0x2a
    op = op_of("\xeb\x2a\xff\xff\x7f\x57", 0)
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base])).to eq '15'
    expect(op.value[:disp]).to be 0x7ffff
  end

  it 'acreg' do
    # ear %r7, %a8
    op = op_of("\xb2\x4f\x00\x78", 1)
    expect(op.reg? && op.acreg?).to be true
    expect(op.value).to be 8
  end
end
