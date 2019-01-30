#!/usr/bin/env ruby
# frozen_string_literal: true

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'crabstone'
require 'stringio'

module TestSparc
  SPARC_CODE = "\x80\xa0\x40\x02\x85\xc2\x60\x08\x85\xe8\x20\x01\x81\xe8\x00\x00\x90\x10\x20\x01\xd5\xf6\x10\x16\x21\x00\x00\x0a\x86\x00\x40\x02\x01\x00\x00\x00\x12\xbf\xff\xff\x10\xbf\xff\xff\xa0\x02\x00\x09\x0d\xbf\xff\xff\xd4\x20\x60\x00\xd4\x4e\x00\x16\x2a\xc2\x80\x03"
  SPARCV9_CODE = "\x81\xa8\x0a\x24\x89\xa0\x10\x20\x89\xa0\x1a\x60\x89\xa0\x00\xe0"

  include Crabstone
  include Crabstone::Sparc

  @platforms = [
    Hash[
      'arch' => ARCH_SPARC,
      'mode' => MODE_BIG_ENDIAN,
      'code' => SPARC_CODE,
      'comment' => 'Sparc'
    ],
    Hash[
      'arch' => ARCH_SPARC,
      'mode' => MODE_BIG_ENDIAN + MODE_V9,
      'code' => SPARCV9_CODE,
      'comment' => 'SparcV9'
    ]
  ]

  def self.uint32(i)
    Integer(i) & 0xffffffff
  end

  def self.print_detail(cs, insn, sio)
    if insn.op_count > 0
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
          if op.value[:index].nonzero?
            sio.puts format("\t\t\toperands[#{idx}].mem.index: REG = %s", cs.reg_name(op.value[:index]))
          end
          sio.puts format("\t\t\toperands[#{idx}].mem.disp: 0x%x", uint32(op.value[:disp])) if op.value[:disp].nonzero?
        end
      end
    end

    sio.puts(format("\tCode condition: %u", insn.cc)) if insn.cc.nonzero?

    sio.puts(format("\tHint code: %u", insn.hint)) if insn.hint.nonzero?

    sio.puts
  end

  ours = StringIO.new

  begin
    cs = Disassembler.new(0, 0)
    print "Sparc Test: Capstone v #{cs.version.join('.')} - "
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
