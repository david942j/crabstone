# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::X86' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
    # lea cx, word ptr [si + 0x32]
    op = op_of("\x8d\x4c\x32", Crabstone::MODE_16, 0)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'cx'
  end

  it 'imm' do
    # push 0x33
    op = op_of("\x6a\x33", Crabstone::MODE_64, 0)
    expect(op.imm?).to be true
    expect(op.value).to be 0x33
  end

  it 'mem' do
    # lea cx, word ptr [si + 0x32]
    op = op_of("\x8d\x4c\x32", Crabstone::MODE_16, 1)
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base])).to eq 'si'
    expect(op.value[:disp]).to be 0x32
  end

  it 'fp' do
    # x86 has no fp operand, it's a bug of Capstone3 and was fixed in Capstone4.
  end
end
