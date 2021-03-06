#!/usr/bin/env ruby
# frozen_string_literal: true

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'English'

require 'crabstone'
# rubocop:disable Style/MixinUsage
include Crabstone
# rubocop:enable Style/MixinUsage

arm =
  "\xED\xFF\xFF\xEB\x04\xe0\x2d\xe5\x00\x00\x00\x00\xe0\x83\x22" \
  "\xe5\xf1\x02\x03\x0e\x00\x00\xa0\xe3\x02\x30\xc1\xe7\x00\x00\x53\xe3"

begin
  cs = Disassembler.new(ARCH_ARM, MODE_ARM)
  puts "Hello from Capstone v #{cs.version.join('.')}!"
  puts 'Disasm:'

  begin
    cs.decomposer = true

    # disasm is an array of Crabstone::Instruction objects
    disasm = cs.disasm(arm, 0x1000)

    disasm.each do |i|
      printf("0x%x:\t%s\t\t%s\n", i.address, i.mnemonic, i.op_str)
    end

    disasm = cs.disasm(arm, 0x1000)
    puts(disasm.map { |i| format("0x%x:\t%s\t\t%s\n", i.address, i.mnemonic, i.op_str) })
  rescue StandardError
    raise "Disassembly error: #{$ERROR_INFO} #{$ERROR_POSITION}"
  ensure
    cs.close
  end
rescue StandardError
  raise "Unable to open engine: #{$ERROR_INFO}"
end
