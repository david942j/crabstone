#!/usr/bin/env ruby
# frozen_string_literal: true

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'crabstone'
require 'stringio'

module TestSysZ
  SYSZ_CODE = "\xed\x00\x00\x00\x00\x1a\x5a\x0f\x1f\xff\xc2\x09\x80\x00\x00\x00\x07\xf7\xeb\x2a\xff\xff\x7f\x57\xe3\x01\xff\xff\x7f\x57\xeb\x00\xf0\x00\x00\x24\xb2\x4f\x00\x78\xec\x18\x00\x00\xc1\x7f"

  include Crabstone
  include Crabstone::SysZ

  @platforms = [
    Hash[
      'arch' => ARCH_SYSZ,
      'mode' => MODE_BIG_ENDIAN,
      'code' => SYSZ_CODE,
      'comment' => 'SystemZ'
    ]
  ]

  def self.uint32(i)
    Integer(i) & 0xffffffff
  end

  def self.uint64(i)
    Integer(i) & 0xffffffffffffffff
  end

  def self.print_detail(cs, insn, sio)
    if insn.op_count > 0
      sio.puts "\top_count: #{insn.op_count}"
      insn.operands.each_with_index do |op, idx|
        case op[:type]
        when OP_REG
          sio.puts "\t\toperands[#{idx}].type: REG = #{cs.reg_name(op.value)}"
        when OP_ACREG
          sio.puts "\t\toperands[#{idx}].type: ACREG = #{op.value}"
        when OP_IMM
          sio.puts "\t\toperands[#{idx}].type: IMM = 0x#{uint64(op.value).to_s(16)}"
        when OP_MEM
          sio.puts "\t\toperands[#{idx}].type: MEM"
          if op.value[:base].nonzero?
            sio.puts format("\t\t\toperands[#{idx}].mem.base: REG = %s", cs.reg_name(op.value[:base]))
          end
          if op.value[:index].nonzero?
            sio.puts format("\t\t\toperands[#{idx}].mem.index: REG = %s", cs.reg_name(op.value[:index]))
          end
          if op.value[:length].nonzero?
            sio.puts format("\t\t\toperands[#{idx}].mem.length: REG = %s", cs.reg_name(op.value[:length]))
          end
          sio.puts format("\t\t\toperands[#{idx}].mem.disp: 0x%x", uint32(op.value[:disp])) if op.value[:disp].nonzero?
        end
      end
    end

    sio.puts(format("\tCode condition: %u", insn.cc)) if insn.cc.nonzero?

    sio.puts
  end

  ours = StringIO.new

  begin
    cs = Disassembler.new(0, 0)
    print "SystemZ Test: Capstone v #{cs.version.join('.')} - "
  ensure
    cs.close
  end

  # Test through all modes and architectures
  @platforms.each do |p|
    ours.puts '****************'
    ours.puts "Platform: #{p['comment']}"
    ours.puts "Code:#{p['code'].bytes.map { |b| format('0x%.2x', b) }.join(' ')} "
    ours.puts 'Disasm:'

    cs = Disassembler.new(p['arch'], p['mode'])
    cs.decomposer = true
    cache = nil

    cs.disasm(p['code'], 0x1000).each do |insn|
      ours.puts "0x#{insn.address.to_s(16)}:\t#{insn.mnemonic}\t#{insn.op_str}"
      print_detail(cs, insn, ours)
      cache = insn.address + insn.size
    end

    ours.printf("0x%x:\n", cache)
    ours.puts
    cs.close
  end

  ours.rewind
  theirs = File.binread(__FILE__ + '.SPEC')
  if ours.read == theirs
    puts "#{__FILE__}: PASS"
  else
    ours.rewind
    puts ours.read
    puts "#{__FILE__}: FAIL"
  end
end
