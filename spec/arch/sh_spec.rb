# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::SH' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_SH, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  before(:all) do
    skip 'Tricore not supported' unless Crabstone.const_defined?(:TRICORE)
    skip 'https://github.com/capstone-engine/capstone/issues/2424'
  end

  it 'reg' do
    # add   r0,r1
    op = op_of("\x0c\x31", Crabstone::MODE_SH4A, 0)
    expect(op.reg?).to be true
    expect(op.value).to be Crabstone::SH::REG_R0
  end

  it 'imm' do
    # add   #12,r1
    op = op_of("\x0c\x71", Crabstone::MODE_SH4A, 0)
    expect(op.imm?).to be true
    expect(op.value).to be 12
  end

  it 'mem' do
    # movu.w@(1024,r1),r2
    op = op_of("\x32\x11\x92\x00", Crabstone::MODE_SH2A | Crabstone::MODE_BIG_ENDIAN, 0)
    expect(op.mem?).to be true
    expect(op.value[:address]).to be Crabstone::SH::OP_MEM_REG_DISP
    expect(op.value[:disp]).to be 1024
    expect(op.value[:reg]).to be Crabstone::SH::REG_R1
  end
end
