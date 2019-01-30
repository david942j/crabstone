#!/usr/bin/env ruby
# frozen_string_literal: true

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'crabstone'
require 'stringio'

module TestMIPS
  MIPS_CODE  = "\x0C\x10\x00\x97\x00\x00\x00\x00\x24\x02\x00\x0c\x8f\xa2\x00\x00\x34\x21\x34\x56"
  MIPS_CODE2 = "\x56\x34\x21\x34\xc2\x17\x01\x00"
  MIPS_32R6M = "\x00\x07\x00\x07\x00\x11\x93\x7c\x01\x8c\x8b\x7c\x00\xc7\x48\xd0"
  MIPS_32R6  = "\xec\x80\x00\x19\x7c\x43\x22\xa0"

  include Crabstone
  include Crabstone::MIPS

  @platforms = [
    Hash[
      'arch' => ARCH_MIPS,
      'mode' => MODE_MIPS32 + MODE_BIG_ENDIAN, # new MODE_MIPS32
      'code' => MIPS_CODE,
      'comment' => 'MIPS-32 (Big-endian)'
    ],
    Hash[
      'arch' => ARCH_MIPS,
      'mode' => MODE_64 + MODE_LITTLE_ENDIAN, # old alias
      'code' => MIPS_CODE2,
      'comment' => 'MIPS-64-EL (Little-endian)'
    ],
    Hash[
      'arch' => ARCH_MIPS,
      'mode' => MODE_MIPS32R6 + MODE_MICRO + MODE_BIG_ENDIAN,
      'code' => MIPS_32R6M,
      'comment' => 'MIPS-32R6 | Micro (Big-endian)'
    ],
    Hash[
      'arch' => ARCH_MIPS,
      'mode' => MODE_MIPS32R6 + MODE_BIG_ENDIAN,
      'code' => MIPS_32R6,
      'comment' => 'MIPS-32R6 (Big-endian)'
    ]
  ]

  def self.uint32(i)
    Integer(i) & 0xffffffff
  end

  def self.print_detail(cs, insn, sio)
    if insn.op_count > 0
      print '[w:ra] ' if insn.writes_reg? :ra
      sio.puts "\top_count: #{insn.op_count}"
      insn.operands.each_with_index do |op, idx|
        case op[:type]
        when OP_REG
          sio.puts "\t\toperands[#{idx}].type: REG = #{cs.reg_name(op.value)}"
        when OP_IMM
          sio.puts "\t\toperands[#{idx}].type: IMM = 0x#{uint32(op.value).to_s(16)}"
        when OP_MEM
          sio.puts "\t\toperands[#{idx}].type: MEM"
          if op.value[:base].nonzero?
            sio.puts format("\t\t\toperands[#{idx}].mem.base: REG = %s", cs.reg_name(op.value[:base]))
          end
          sio.puts format("\t\t\toperands[#{idx}].mem.disp: 0x%x", uint32(op.value[:disp])) if op.value[:disp].nonzero?
        end
      end
    end
    sio.puts
  end

  ours = StringIO.new

  begin
    cs = Disassembler.new(0, 0)
    print "MIPS Test: Capstone v #{cs.version.join('.')} - "
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

    cs.close
    ours.printf("0x%x:\n", cache)
    ours.puts
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
