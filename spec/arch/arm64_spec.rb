# frozen_string_literal: true

require 'crabstone/disassembler'

describe Crabstone::ARM64 do
  def op_of(code, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_ARM64, Crabstone::MODE_ARM)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
    # mrs     x9, midr_el1
    op = op_of("\x09\x00\x38\xd5", 0)
    expect(op.valid?).to be true
    expect(op.reg?).to be true
    expect(@cs.reg_name(op.value)).to eq 'x9'
  end

  it 'imm' do
    # msr     spsel, #0x1
    op = op_of("\xbf\x41\x00\xd5", 1)
    expect(op.imm?).to be true
    expect(op.value).to be 1
  end

  it 'mem' do
    # prfm    pldl1keep, [x26, w6, uxtw]
    op = op_of("\x40\x4b\xa6\xf8", 1)
    expect(op.mem?).to be true
    expect(@cs.reg_name(op.value[:base])).to eq 'x26'
    expect(@cs.reg_name(op.value[:index])).to eq 'w6'

    expect(op.ext?).to be true
    expect(op[:ext]).to be Crabstone::ARM64::EXT_UXTW
  end

  it 'fp' do
    op = op_of("\x02\x10\x28\x1e", 1)
    expect(op.fp?).to be true
    expect(op.value).to eq 0.125
  end

  it 'cimm' do
    # sys #7, c5, c9, #7, x5
    op = op_of("\xe5\x59\x0f\xd5", 1)
    expect(op.imm? && op.cimm?).to be true
    expect(op.value).to be 5
  end

  it 'reg_mrs' do
    # mrs     x9, midr_el1
    op = op_of("\x09\x00\x38\xd5", 1)
    expect(op.reg_mrs?).to be true
    expect(op.value).to be Crabstone::ARM64::SYSREG_MIDR_EL1
  end

  it 'reg_msr' do
    # msr     dbgdtrrx_el0, x12
    op = op_of("\x0c\x05\x13\xd5", 0)
    expect(op.reg_msr?).to be true
    expect(op.value).to be Crabstone::ARM64::SYSREG_DBGDTRTX_EL0
  end

  it 'pstate' do
    # msr     spsel, #0x1
    op = op_of("\xbf\x41\x00\xd5", 0)
    expect(op.pstate?).to be true
    expect(op.value).to be Crabstone::ARM64::PSTATE_SPSEL
  end

  it 'sys' do
    # ic ialluis
    op = op_of("\x1f\x71\x08\xd5", 0)
    expect(op.sys?).to be true
    expect(op.value).to be Crabstone::ARM64::IC_IALLUIS
  end

  it 'prefetch' do
    # prfm    pldl1keep, [x26, w6, uxtw]
    op = op_of("\x40\x4b\xa6\xf8", 0)
    expect(op.prefetch?).to be true
    expect(op.value).to be Crabstone::ARM64::PRFM_PLDL1KEEP
  end

  it 'barrier' do
    # dsb     ishst
    op = op_of("\x9f\x3a\x03\xd5", 0)
    expect(op.barrier?).to be true
    expect(op.value).to be Crabstone::ARM64::BARRIER_ISHST
  end

  it 'shift' do
    # add     x0, x1, x2, lsl #2
    op = op_of("\x20\x08\x02\x8b", 2)
    expect(op.shift?).to be true
    expect(op[:shift][:value]).to be 2
  end
end
