# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::TMS320C64X' do
  def inst_of(code)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_TMS320C64X, Crabstone::MODE_BIG_ENDIAN)
    cs.decomposer = true
    cs.disasm(code, 0).first
  end

  before(:all) do
    skip 'TMS320C64X not supported' unless Crabstone.const_defined?(:TMS320C64X)
  end

  it 'reg' do
    # add.D1   a11, 4, a3
    op = inst_of("\x01\xac\x89\x40").operands[0]
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'a11'

    op = inst_of("\x01\xac\x89\x40").operands[2]
    expect(@cs.reg_name(op.value)).to eq 'a3'
  end

  it 'imm' do
    # add.D1   a11, 4, a3
    op = inst_of("\x01\xac\x89\x40").operands[1]
    expect(op.imm?).to be true
    expect(op.value).to be 4
  end

  it 'mem' do
    # ldndw.d1t1        *+a3(a4), a23:a22
    op = inst_of("\x0b\x0c\x8b\x24").operands[0]
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base])).to eq 'a3'

    expect(op.value[:disptype]).to be Crabstone::TMS320C64X::MEM_DISP_REGISTER
    expect(@cs.reg_name(op.value[:disp])).to eq 'a4'

    expect(op.value[:direction]).to be Crabstone::TMS320C64X::MEM_DIR_FW
    expect(op.value[:modify]).to be Crabstone::TMS320C64X::MEM_MOD_NO
  end

  it 'regpair' do
    # ldndw.d1t1        *+a3(a4), a23:a22
    op = inst_of("\x0b\x0c\x8b\x24").operands[1]
    expect(op.reg? && op.regpair?).to be true
    expect(@cs.reg_name(op.value)).to eq 'a22'
  end

  it 'instruction attributes' do
    # [ a1] add.d2    b11, b4, b3     ||
    inst = inst_of("\x81\xac\x88\x43")
    expect(inst.funit[:unit]).to be Crabstone::TMS320C64X::FUNIT_D
    expect(inst.funit[:side]).to be 2
    expect(inst.parallel).to be 1
    expect(@cs.reg_name(inst.condition[:reg])).to eq 'a1'
  end
end
