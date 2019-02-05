# frozen_string_literal: true

require 'crabstone/constants'
require 'crabstone/cs_version'

# require all files under 'crabstone/arch/<cs_major_version>'
Dir.glob(File.join(__dir__, 'arch', Crabstone.cs_major_version.to_s, '*.rb')).each do |f|
  require f
end

module Crabstone
  module Arch
    module_function

    # @param [Integer] arch
    # @return [Module]
    # @example
    #   Arch.module_of(Crabstone::ARCH_X86)
    #   #=> Crabstone::X86
    def module_of(arch)
      case arch
      when ARCH_ARM then ARM
      when ARCH_ARM64 then ARM64
      when ARCH_X86 then X86
      when ARCH_MIPS then MIPS
      when ARCH_PPC then PPC
      when ARCH_SPARC then Sparc
      when ARCH_SYSZ then SysZ
      when ARCH_XCORE then XCore
      when ARCH_M68K then M68K
      when ARCH_TMS320C64X then TMS320C64X
      when ARCH_M680X then M680X
      when ARCH_EVM then EVM
      end
    end
  end
end
