# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::XCore' do
  def op_of(code, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_XCORE, Crabstone::MODE_BIG_ENDIAN)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
    # ldw et, sp[4]
    op = op_of("\xfe\x17", 0)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'et'
  end

  it 'imm' do
    # bl 0x69
    op = op_of("\x69\xd0", 0)
    expect(op.imm?).to be true
    expect(op.value).to be 0x69
  end

  it 'mem' do
    # ldaw r8, r2[-9]
    op = op_of("\x09\xfd\xec\xa7", 1)
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base])).to eq 'r2'
    expect(op.value[:disp]).to be 9
    expect(op.value[:direct]).to be(-1)
  end
end
