#!/usr/bin/env ruby
# frozen_string_literal: true

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'crabstone'
require 'stringio'

module TestPPC
  PPC_CODE = "\x43\x20\x0c\x07\x41\x56\xff\x17\x80\x20\x00\x00\x80\x3f\x00\x00\x10\x43\x23\x0e\xd0\x44\x00\x80\x4c\x43\x22\x02\x2d\x03\x00\x80\x7c\x43\x20\x14\x7c\x43\x20\x93\x4f\x20\x00\x21\x4c\xc8\x00\x21\x40\x82\x00\x14"
  include Crabstone
  include Crabstone::PPC

  @platforms = [
    Hash[
      'arch' => ARCH_PPC,
      'mode' => MODE_BIG_ENDIAN,
      'code' => PPC_CODE,
      'comment' => 'PPC-64'
    ]
  ]

  def self.uint32(i)
    Integer(i) & 0xffffffff
  end

  def self.bc_name(bc)
    case bc
    when BC_INVALID
      'invalid'
    when BC_LT
      'lt'
    when BC_LE
      'le'
    when BC_EQ
      'eq'
    when BC_GE
      'ge'
    when BC_GT
      'gt'
    when BC_NE
      'ne'
    when BC_UN
      'un'
    when BC_NU
      'nu'
    when BC_SO
      'so'
    when BC_NS
      'ns'
    end
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
        when OP_CRX
          sio.puts "\t\toperands[#{idx}].type: CRX\n"
          sio.puts "\t\t\toperands[#{idx}].crx.scale: #{op.value[:scale]}"
          sio.puts format("\t\t\toperands[#{idx}].crx.reg: %s", cs.reg_name(op.value[:reg]))
          sio.puts format("\t\t\toperands[#{idx}].crx.cond: %s", bc_name(op.value[:cond]))
        end
      end
    end
    sio.puts(format("\tBranch code: %u", insn.bc)) if insn.bc.nonzero?
    sio.puts(format("\tBranch hint: %u", insn.bh)) if insn.bh.nonzero?
    sio.puts("\tUpdate-CR0: True") if insn.update_cr0
    sio.puts
  end

  ours = StringIO.new

  begin
    cs = Disassembler.new(0, 0)
    print "PPC Test: Capstone v #{cs.version.join('.')} - "
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
