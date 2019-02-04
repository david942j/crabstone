# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::M68K' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_M68K, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end

  it 'reg' do
  end

  it 'imm' do
  end

  it 'mem' do
  end

  it 'fp_single' do
  end

  it 'fp_double' do
  end

  it 'reg_bits' do
  end

  it 'reg_pair' do
  end

  it 'br_disp' do
  end

  it 'br_disp_size_byte' do
  end

  it 'br_disp_size_word' do
  end

  it 'br_disp_size_long' do
  end
end
