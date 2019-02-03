# encoding: ascii-8bit
# frozen_string_literal: true

require 'crabstone/disassembler'
require 'crabstone/instruction'

describe Crabstone::Instruction do
  # It's complicated to create an Instruction object,
  # so we simply utilize disassembler for creating.
  before(:all) do
    cs = Crabstone::Disassembler.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    cs.decomposer = true
    # mov rax, rbp
    @inst = cs.disasm("\x48\x89\xE8", 0).first
  end

  it 'api methods' do
    expect(@inst.name).to eq 'mov'
    expect(@inst.bytes).to eq [0x48, 0x89, 0xe8]
    expect(@inst.op_count).to be 2
    expect(@inst.op_count(Crabstone::X86::OP_IMM)).to be 0
  end

  it 'method_missing and respond_to_missing?' do
    expect(@inst.respond_to?(:operands)).to be true
    expect(@inst.respond_to?(:no_such_method)).to be false
    expect(@inst.opcode.to_a).to eq [0x89, 0, 0, 0]
    expect(@inst.rex.to_i).to be 0x48
    expect { @inst.xdd }.to raise_error(NoMethodError)
    allow(@inst).to receive(:detailed?).and_return(false)
    expect { @inst.operands }.to raise_error(NoMethodError)
  end
end
