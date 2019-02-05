# encoding: ascii-8bit
# frozen_string_literal: true

require 'crabstone/disassembler'
require 'crabstone/instruction'

describe Crabstone::Instruction do
  # It's complicated to create an Instruction object,
  # so we simply utilize disassembler for creating.
  before(:all) do
    @cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    @cs.decomposer = true
  end

  it 'api methods' do
    # mov rax, rbp
    inst = @cs.disasm("\x48\x89\xE8", 0).first
    expect(inst.name).to eq 'mov'
    expect(inst.bytes).to eq [0x48, 0x89, 0xe8]
    expect(inst.op_count).to be 2
    expect(inst.op_count(Crabstone::X86::OP_IMM)).to be 0
  end

  it 'read/write reg' do
    # leave // equivalent to (mov rsp, rbp; pop rbp)
    inst = @cs.disasm("\xc9", 0).first
    expect(inst.regs_read).to eq [Crabstone::X86::REG_RBP, Crabstone::X86::REG_RSP]
    expect(inst.reads_reg?('rsp')).to be true
    expect(inst.reads_reg?('rbp')).to be true

    expect(inst.regs_write).to eq [Crabstone::X86::REG_RBP, Crabstone::X86::REG_RSP]
    expect(inst.writes_reg?('rsp')).to be true
    expect(inst.writes_reg?(Crabstone::X86::REG_RBP)).to be true
    expect(inst.writes_reg?(31_337)).to be false
  end

  it 'regs_access' do
    skip 'cs_regs_access not supported yet' unless Crabstone::Binding.respond_to?(:cs_regs_access)
    # push rax
    inst = @cs.disasm('P', 0).first
    access = inst.regs_access
    expect(access[:regs_read].sort).to eq [Crabstone::X86::REG_RAX, Crabstone::X86::REG_RSP]
    expect(access[:regs_write]).to eq [Crabstone::X86::REG_RSP]
  end

  it 'groups' do
    # leave // equivalent to (mov rsp, rbp; pop rbp)
    inst = @cs.disasm("\xc9", 0).first
    expect(inst.groups).to eq [Crabstone::X86::GRP_MODE64]
    expect(inst.group?(Crabstone::X86::GRP_MODE64)).to be true
    expect(inst.group_name(Crabstone::X86::GRP_MODE64)).to eq 'mode64'
  end

  it 'method_missing and respond_to_missing?' do
    # mov rax, rbp
    inst = @cs.disasm("\x48\x89\xE8", 0).first
    expect(inst.respond_to?(:operands)).to be true
    expect(inst.respond_to?(:no_such_method)).to be false
    expect(inst.opcode.to_a).to eq [0x89, 0, 0, 0]
    expect(inst.rex.to_i).to be 0x48
    expect { inst.xdd }.to raise_error(NoMethodError)
    allow(inst).to receive(:detailed?).and_return(false)
    expect { inst.operands }.to raise_error(NoMethodError)
  end

  it 'release' do
    inst = @cs.disasm("\xc3", 0).first
    Crabstone::Binding::Instruction.release(inst.raw_insn)
  end
end
