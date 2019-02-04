# frozen_string_literal: true

require 'crabstone/disassembler'

describe Crabstone::Sparc do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_SPARC, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
    # fcmps f0, f4
    op = op_of("\x81\xa8\x0a\x24", Crabstone::MODE_BIG_ENDIAN | Crabstone::MODE_V9, 0)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'f0'

    op = op_of("\x81\xa8\x0a\x24", Crabstone::MODE_BIG_ENDIAN | Crabstone::MODE_V9, 1)
    expect(@cs.reg_name(op.value)).to eq 'f4'
  end

  it 'imm' do
    # bne -4
    op = op_of("\x12\xbf\xff\xff", Crabstone::MODE_BIG_ENDIAN, 0)
    expect(op.imm?).to be true
    expect(op.value).to be(-4)
    expect(@cs.disasm("\x12\xbf\xff\xff", 0).first.cc).to be Crabstone::Sparc::CC_ICC_NE
  end

  it 'mem' do
    # ldsb [i0+l6], o2
    op = op_of("\xd4\x4e\x00\x16", Crabstone::MODE_BIG_ENDIAN, 0)
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base])).to eq 'i0'
    expect(@cs.reg_name(op.value[:index])).to eq 'l6'
  end
end
