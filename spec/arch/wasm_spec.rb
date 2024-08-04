# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::WASM' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_WASM, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  before(:all) do
    skip 'WASM not supported' unless Crabstone.const_defined?(:WASM)
  end

  it 'int7' do
    # block        14
    op = op_of("\x02\x0e", 0, 0)
    expect(op.int7?).to be true
    expect(op.value).to be 14
  end

  it 'varuint32' do
    # f32.load       0x3190, 0x0
    op = op_of("\x2a\x90\x63\x00", 0, 0)
    expect(op.varuint32?).to be true
    expect(op.value).to be 0x3190
  end

  it 'varuint64' do
    # i64.const    0x2e
    op = op_of("\x42\x2e", 0, 0)
    expect(op.varuint64?).to be true
    expect(op.value).to be 0x2e
  end

  it 'uint32' do
    # f32.const   0xa3bab88f
    op = op_of("\x43\x8f\xb8\xba\xa3", 0, 0)
    expect(op.uint32?).to be true
    expect(op.value).to be 0xa3bab88f
  end

  it 'uint64' do
    # 44 ed 4a 8b 55 1b e2 4f 47  f64.const       0x474fe21b558b4aed
    op = op_of("\x44\xed\x4a\x8b\x55\x1b\xe2\x4f\x47", 0, 0)
    expect(op.uint64?).to be true
    expect(op.value).to eq 0x474fe21b558b4aed
  end

  it 'brtable' do
    #  0e 00 2e  br_table  0x0, [0x2], 0x2e
    op = op_of("\x0e\x00\x2e", 0, 0)
    expect(op.brtable?).to be true
    expect(op.value[:length]).to be 0
    expect(op.value[:address]).to be 0x2
    expect(op.value[:default_target]).to be 0x2e
  end
end
