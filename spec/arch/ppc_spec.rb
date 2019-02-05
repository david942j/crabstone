# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::PPC' do
  def op_of(code, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_PPC, Crabstone::MODE_BIG_ENDIAN)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
    # stfs    f2, 0x80(r4)
    op = op_of("\xd0\x44\x00\x80", 0)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'f2'
  end

  it 'imm' do
    # bdztla  4*cr5+eq,0xffffffe4
    op = op_of("\x41\x56\xff\xe7", 1)
    expect(op.imm?).to be true
    expect(op.value).to be(-0x1c)
  end

  it 'mem' do
    # stfs    f2, 0x80(r4)
    op = op_of("\xd0\x44\x00\x80", 1)
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base])).to eq 'r4'
    expect(op.value[:disp]).to be 0x80
  end

  it 'crx' do
    # bdztla  4*cr5+eq,0xffffffe4
    op = op_of("\x41\x56\xff\xe7", 0)
    expect(op.crx?).to be true
    expect(op.value[:scale]).to be
    expect(@cs.reg_name(op.value[:reg])).to eq 'cr5'
    expect(op.value[:cond]).to be Crabstone::PPC::BC_EQ
  end
end
