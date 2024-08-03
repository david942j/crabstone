# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::BPF' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_BPF, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  before(:all) do
    skip 'BPF not supported' unless Crabstone.const_defined?(:BPF)
  end

  it 'reg' do
    # mul x
    op = op_of("\x2c\x00\x00\x00\x00\x00\x00\x00", Crabstone::MODE_BPF_CLASSIC, 0)
    expect(op.reg?).to be true
    expect(op.value).to be Crabstone::BPF::REG_X
  end

  it 'imm' do
    # jset 0xed34a17d, +0x43, +0xfc
    op = op_of("\x45\x00\x43\xfc\x7d\xa1\x34\xed", Crabstone::MODE_BPF_CLASSIC, 0)
    expect(op.imm?).to be true
    expect(op.value).to be 0xed34a17d
  end

  it 'off' do
    # jset 0xed34a17d, +0x43, +0xfc
    op = op_of("\x45\x00\x43\xfc\x7d\xa1\x34\xed", Crabstone::MODE_BPF_CLASSIC, 1)
    expect(op.off?).to be true
    expect(op.value).to be 0x43
  end

  it 'mem' do
    # ld [x+0x257289d9]
    op = op_of("\x40\x00\xf1\xa0\xd9\x89\x72\x25", Crabstone::MODE_BPF_CLASSIC, 0)
    expect(op.mem?).to be true
    expect(op.value[:base]).to be Crabstone::BPF::REG_X
    expect(op.value[:disp]).to be 0x257289d9
  end

  it 'mmem' do
    # st m[0x0b]
    op = op_of("\x62\x00\x2c\x44\x0b\x00\x00\x00", Crabstone::MODE_BPF_CLASSIC, 0)
    expect(op.mmem?).to be true
    expect(op.value[:base]).to be 0x0b
  end

  it 'msh' do
    # ldx 4*([0xe3d4dfdd]&0xf)
    op = op_of("\xa1\x00\x53\x03\xdd\xdf\xd4\xe3", Crabstone::MODE_BPF_CLASSIC, 0)
    expect(op.msh?).to be true
    expect(op.value).to be 0xe3d4dfdd
  end

  it 'ext' do
    # ld #len
    op = op_of("\x80\x00\x00\x00\x00\x00\x00\x00", Crabstone::MODE_BPF_CLASSIC, 0)
    expect(op.ext?).to be true
    expect(op.value).to be Crabstone::BPF::EXT_LEN
  end

  it 'extended' do
    # xaddw [r2+0x10], r1
    code = "\xc3\x12\x00\x10\x00\x00\x00\x00"
    expect { op_of(code, Crabstone::MODE_BIG_ENDIAN | Crabstone::MODE_BPF_CLASSIC, 1) }.to raise_error

    op = op_of(code, Crabstone::MODE_BIG_ENDIAN | Crabstone::MODE_BPF_EXTENDED, 1)
    expect(op.value).to eq Crabstone::BPF::REG_R1
  end
end
