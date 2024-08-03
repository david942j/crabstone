# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::TRICORE' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_TRICORE, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  before(:all) do
    skip 'Tricore not supported' unless Crabstone.const_defined?(:TRICORE)
  end

  it 'reg' do
    # ld.bu  d15, [a15]#0x81
    op = op_of("\x09\xff\x41\x28", Crabstone::MODE_TRICORE_162, 0)
    expect(op.reg?).to be true
    expect(op.value).to be Crabstone::TRICORE::REG_D15
  end

  it 'imm' do
    # loop   a0, #0x20a
    op = op_of("\xfd\x00\x05\x01", Crabstone::MODE_TRICORE_162, 1)
    expect(op.imm?).to be true
    expect(op.value).to be 0x20a
  end

  it 'mem' do
    # ld.bu  d15, [a15]#0x81
    op = op_of("\x09\xff\x41\x28", Crabstone::MODE_TRICORE_162, 1)
    expect(op.mem?).to be true
    expect(op.value[:base]).to be Crabstone::TRICORE::REG_A15
    expect(op.value[:disp]).to be 0x81
  end
end
