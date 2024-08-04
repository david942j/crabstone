# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::RISCV' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_RISCV, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  before(:all) do
    skip 'RISCV not supported' unless Crabstone.const_defined?(:RISCV)
  end

  it 'reg' do
    # amoswap.w.rl t3, a0, (s5)
    op = op_of("\x2f\xae\xaa\x0a", Crabstone::MODE_RISCV32, 1)
    expect(op.reg?).to be true
    expect(op.value).to be Crabstone::RISCV::REG_X10
  end

  it 'imm' do
    # auipc t0, 8
    op = op_of("\x97\x82\x00\x00", Crabstone::MODE_RISCV32, 1)
    expect(op.imm?).to be true
    expect(op.value).to be 8
  end

  it 'mem' do
    # fsw ft6, 0x14(s5)
    op = op_of("\x27\xaa\x6a\x00", Crabstone::MODE_RISCV32, 1)
    expect(op.mem?).to be true
    expect(op.value[:base]).to be Crabstone::RISCV::REG_X21
    expect(op.value[:disp]).to be 0x14
  end
end
