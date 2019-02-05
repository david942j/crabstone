# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::M680X' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_M680X, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  before(:all) do
    skip 'M680X not supported' unless Crabstone.const_defined?(:M680X)
  end

  it 'register' do
    # muld  -16,x
    op = op_of("\x11\xaf\x10", Crabstone::MODE_M680X_6309, 0)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'd'
  end

  it 'immediate' do
    # brclr $7F,#-128,$0004
    op = op_of("\x4f\x7f\x80\x00", Crabstone::MODE_M680X_CPU12, 1)
    expect(op.immediate?).to be true
    expect(op.value).to be(-128)
  end

  it 'indexed' do
    # muld  -16,x
    op = op_of("\x11\xaf\x10", Crabstone::MODE_M680X_6309, 1)
    expect(op.valid?).to be true
    expect(op.indexed?).to be true
    expect(@cs.reg_name(op.value[:base_reg])).to eq 'x'
    expect(op.value[:offset]).to be(-16)
    expect(op.value[:offset_bits]).to be 5
  end

  it 'extended' do
    # call   $1000,4
    op = op_of("\x4a\x10\x00\x04", Crabstone::MODE_M680X_CPU12, 0)
    expect(op.extended?).to be true
    expect(op.value[:address]).to be 0x1000
    expect(op.value[:indirect]).to be false
  end

  it 'direct' do
    # brclr $7F,#-128,$0004
    op = op_of("\x4f\x7f\x80\x00", Crabstone::MODE_M680X_CPU12, 0)
    expect(op.direct?).to be true
    expect(op.value).to be(0x7f)
  end

  it 'relative' do
    # brclr $7F,#-128,$0004
    op = op_of("\x4f\x7f\x80\x00", Crabstone::MODE_M680X_CPU12, 2)
    expect(op.relative?).to be true
    expect(op.value[:address]).to be 4
  end

  it 'constant' do
    # call   $1000,4
    op = op_of("\x4a\x10\x00\x04", Crabstone::MODE_M680X_CPU12, 1)
    expect(op.constant?).to be true
    expect(op.value).to be 4
  end
end
