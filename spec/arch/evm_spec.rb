# frozen_string_literal: true

require 'crabstone/disassembler'

describe 'Crabstone::EVM' do
  def op_of(code, mode, index)
    @cs = cs = Crabstone::Disassembler.new(Crabstone::ARCH_EVM, mode)
    cs.decomposer = true
    cs.disasm(code, 0).first.operands[index]
  end
end
