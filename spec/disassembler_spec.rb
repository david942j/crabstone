# encoding: ascii-8bit
# frozen_string_literal: true

require 'crabstone/disassembler'

describe Crabstone::Disassembler do
  it 'simple' do
    cs = described_class.new(Crabstone::ARCH_ARM, Crabstone::MODE_ARM)
    expect(cs.diet?).to be false

    inst = cs.disasm("\xED\xFF\xFF\xEB", 0x1000).first
    expect(inst.address).to be 0x1000
    expect(inst.mnemonic.to_s).to eq 'bl'
    expect(inst.op_str.to_s).to eq '#0xfbc'
    cs.close
  end

  it 'syntax' do
    cs = described_class.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    inst = cs.disasm("H\x89\xE8", 0).first
    expect("#{inst.mnemonic} #{inst.op_str}").to eq 'mov rax, rbp'
    cs.syntax = :att
    inst = cs.disasm("H\x89\xE8", 0).first
    expect("#{inst.mnemonic} #{inst.op_str}").to eq 'movq %rbp, %rax'

    expect { cs.syntax = :invalid }.to raise_error(Crabstone::ErrOption)
  end

  it 'decomposer' do
    cs = described_class.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    inst = cs.disasm("H\x89\xE8", 0).first
    expect { inst.detail }.to raise_error(Crabstone::ErrDetail)
    cs.decomposer = true
    inst = cs.disasm("H\x89\xE8", 0).first
    # Just check the detail field exists
    expect(inst.detailed?).to be true
    expect(inst.detail).to be_a(Crabstone::Binding::Detail)
  end

  it 'reg_name' do
    cs = described_class.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    expect(cs.reg_name(1)).to eq 'ah'
  end

  it 'skipdata' do
    cs = described_class.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    expect(cs.disasm("\x90\xFFP", 0).map { |i| i.mnemonic.to_s }).to eq %w[nop]

    cs.skipdata do |code, offset|
      expect(code[offset]).to eq "\xff"
      1
    end
    expect(cs.disasm("\x90\xFFP", 0).map { |i| i.mnemonic.to_s }).to eq %w[nop .byte push]

    cs.skipdata_off
    expect(cs.disasm("\x90\xFFP", 0).map { |i| i.mnemonic.to_s }).to eq %w[nop]

    cs.skipdata { raise 'ggsmida' }
    expect { cs.disasm("\xff", 0) }
      .to output("Error in skipdata callback: ggsmida\n").to_stderr
                                                         .and raise_error(Crabstone::ErrOK)
  end

  it 'disasm error' do
    cs = described_class.new(Crabstone::ARCH_ARM, Crabstone::MODE_ARM)
    # XXX: Is this behavior correct?
    expect { cs.disasm('A', 0) }.to raise_error(Crabstone::ErrOK)
  end

  it 'version' do
    cs = described_class.new(Crabstone::ARCH_X86, Crabstone::MODE_64)
    expect(cs.version.first <= Crabstone::BINDING_MAJ).to be true
  end

  it 'initialize error' do
    expect { described_class.new(Crabstone::ARCH_MAX, 0) }.to raise_error(Crabstone::ErrArch)
  end
end
