# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::M68K' do
  def op_of(code, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_M68K, Crabstone::MODE_BIG_ENDIAN | Crabstone::MODE_M68K_040)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  before(:all) do
    skip 'M68K not supported' unless Crabstone.const_defined?(:M68K)
  end

  it 'reg' do
    # fadd.s  #3.141500, fp0
    op = op_of("\xf2\x3c\x44\x22\x40\x49\x0e\x56", 1)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'fp0'
  end

  it 'imm' do
    # andi.l  #$c0dec0de, (a4, d5.l * 4)
    op = op_of("\x02\xb4\xc0\xde\xc0\xde\x5c\x00", 0)
    expect(op.imm?).to be true
    expect(op.value).to be 0xc0dec0de - 2**32
  end

  it 'mem' do
    # andi.l  #$c0dec0de, (a4, d5.l * 4)
    op = op_of("\x02\xb4\xc0\xde\xc0\xde\x5c\x00", 1)
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base_reg])).to eq 'a4'
    expect(@cs.reg_name(op.value[:index_reg])).to eq 'd5'
    expect(op.value[:index_size]).to be 1
    expect(op.value[:scale]).to be 4
  end

  it 'fp_single' do
    # fadd.s  #3.141500, fp0
    op = op_of("\xf2\x3c\x44\x22\x40\x49\x0e\x56", 0)
    expect(op.fp_single?).to be true
    expect(op.value).to be_within(0.001).of 3.1415
  end

  it 'fp_double' do
    # fadd.d #2.718280, fp0
    op = op_of("\xf2\x3c\x54\x22\x40\x05\xbf\x09\x95\xaa\xf7\x90", 0)
    expect(op.fp_double?).to be true
    # There's a bug of Casptone 4, the fixes PR is here: aquynh/capstone#1369,
    # so we simply check the type but not the value.
    expect(op.value).to be_a Float
  end

  it 'reg_bits' do
    # fmovem  fp0, d0
    op = op_of("\xfa\x00\xe0\x01", 0)
    expect(op.reg_bits?).to be true
    expect(op.value).to be(1 << 16)
  end

  it 'reg_pair' do
    # divs.l d0, d1:d7
    op = op_of("\x4c\x40\x7c\x01", 1)
    expect(op.reg_pair?).to be true
    expect(@cs.reg_name(op.value[:reg_0])).to eq 'd1'
    expect(@cs.reg_name(op.value[:reg_1])).to eq 'd7'
  end

  it 'br_disp' do
    # fdbf     d0, $8
    op = op_of("\xf0\x48\x00\x00\x00\x04", 1)
    expect(op.br_disp?).to be true
    expect(op.value[:disp]).to be 6
    expect(op.value[:disp_size]).to be Crabstone::M68K::OP_BR_DISP_SIZE_WORD
  end

  it 'address_mode' do
    # andi.l  #$c0dec0de, (a4, d5.l * 4)
    op = op_of("\x02\xb4\xc0\xde\xc0\xde\x5c\x00", 1)
    expect(op[:address_mode]).to be Crabstone::M68K::AM_AREGI_INDEX_BASE_DISP
  end
end
