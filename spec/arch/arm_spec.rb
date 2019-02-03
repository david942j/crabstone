# frozen_string_literal: true

require 'crabstone/disassembler'

describe Crabstone::ARM do
  def inst_of(code, mode)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_ARM, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first
  end

  it 'reg' do
    # str     lr, [sp, #-4]!
    inst = inst_of("\x04\xe0\x2d\xe5", Crabstone::MODE_ARM)
    op = inst.operands[0]
    expect(op.valid?).to be true
    expect(@cs.reg_name(op.value)).to eq 'lr'
  end

  it 'mem' do
    # str     lr, [sp, #-4]!
    inst = inst_of("\x04\xe0\x2d\xe5", Crabstone::MODE_ARM)
    op = inst.operands[1]
    expect(@cs.reg_name(op.value[:base])).to eq 'sp'
    expect(op.value[:disp]).to be -4
  end

  it 'imm' do
    # mcreq   2, 0, r0, cr3, cr1, {7}
    inst = inst_of("\xf1\x02\x03\x0e", Crabstone::MODE_ARM)
    op = inst.operands[1]
    expect(op.value).to be 0
    op = inst.operands[5]
    expect(op.value).to be 7
  end

  it 'cimm' do
    # mcreq   2, 0, r0, cr3, cr1, {7}
    inst = inst_of("\xf1\x02\x03\x0e", Crabstone::MODE_ARM)
    op = inst.operands[3]
    expect(op.cimm?).to be true
    expect(op.value).to be 3
    op = inst.operands[4]
    expect(op.value).to be 1
  end

  it 'pimm' do
    # mcreq   2, 0, r0, cr3, cr1, {7}
    inst = inst_of("\xf1\x02\x03\x0e", Crabstone::MODE_ARM)
    op = inst.operands[0]
    expect(op.pimm?).to be true
    expect(op.value).to be 2
  end

  it 'fp' do
    # vmov.f64 d16, #3.000000e+00
    inst = inst_of("\x08\x0b\xf0\xee", Crabstone::MODE_ARM)
    op = inst.operands[1]
    expect(op.fp?).to be true
    expect(op.value).to eq 3.0
  end

  it 'sysreg' do
    # msr     CPSR_fc, r6
    inst = inst_of("\x86\xf3\x00\x89", Crabstone::MODE_THUMB)
    op = inst.operands[0]
    expect(op.sysreg?).to be true
    expect(op.value).to be Crabstone::ARM::SYSREG_CPSR_C | Crabstone::ARM::SYSREG_CPSR_F
  end

  it 'setend' do
    # setend  be
    inst = inst_of("\x00\x02\x01\xf1", Crabstone::MODE_ARM)
    op = inst.operands[0]
    expect(op.setend?).to be true
    expect(op.value).to be Crabstone::ARM::SETEND_BE
  end
end
