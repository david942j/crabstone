#!/usr/bin/env ruby

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

# This is UGLY, but it's ported C test code, sorry. :(

require 'crabstone'
require 'stringio'

module TestX86
  X86_CODE64 = "\x55\x48\x8b\x05\xb8\x13\x00\x00".freeze
  X86_CODE16 = "\x8d\x4c\x32\x08\x01\xd8\x81\xc6\x34\x12\x00\x00\x05\x23\x01\x00\x00\x36\x8b\x84\x91\x23\x01\x00\x00\x41\x8d\x84\x39\x89\x67\x00\x00\x8d\x87\x89\x67\x00\x00\xb4\xc6".freeze
  X86_CODE32 = "\x8d\x4c\x32\x08\x01\xd8\x81\xc6\x34\x12\x00\x00\x05\x23\x01\x00\x00\x36\x8b\x84\x91\x23\x01\x00\x00\x41\x8d\x84\x39\x89\x67\x00\x00\x8d\x87\x89\x67\x00\x00\xb4\xc6".freeze

  include Crabstone
  include Crabstone::X86

  @platforms = [
    Hash[
      'arch' => ARCH_X86,
      'mode' => MODE_16,
      'code' => X86_CODE16,
      'comment' => 'X86 16bit (Intel syntax)'
    ],
    Hash[
      'arch' => ARCH_X86,
      'mode' => MODE_32,
      'code' => X86_CODE32,
      'syntax' => :att,
      'comment' => 'X86 32 (AT&T syntax)'
    ],
    Hash[
      'arch' => ARCH_X86,
      'mode' => MODE_32,
      'code' => X86_CODE32,
      'comment' => 'X86 32 (Intel syntax)'
    ],
    Hash[
      'arch' => ARCH_X86,
      'mode' => MODE_64,
      'code' => X86_CODE64,
      'comment' => 'X86 64 (Intel syntax)'
    ]
  ]

  def self.uint32(i)
    Integer(i) & 0xffffffff
  end

  def self.uint64(i)
    Integer(i) & 0xffffffffffffffff
  end

  def self.print_detail(cs, i, mode, sio)
    sio.puts("\tPrefix:#{i.prefix.to_a.map { |b| format('0x%.2x', b) }.join(' ')} ")
    sio.puts("\tOpcode:#{i.opcode.to_a.map { |b| format('0x%.2x', b) }.join(' ')} ")
    sio.printf("\trex: 0x%x\n", uint32(i[:rex]))
    sio.printf("\taddr_size: %u\n", uint32(i[:addr_size]))
    sio.printf("\tmodrm: 0x%x\n", i.modrm)
    sio.printf("\tdisp: 0x%x\n", uint32(i.disp))

    #   // SIB is not available in 16-bit mode
    unless mode == MODE_16
      sio.printf("\tsib: 0x%x\n", i.sib)
      unless i.sib_index == REG_INVALID
        sio.printf(
          "\t\tsib_base: %s\n\t\tsib_index: %s\n\t\tsib_scale: %u\n",
          cs.reg_name(i.sib_base),
          cs.reg_name(i.sib_index),
          i.sib_scale
        )
      end
    end

    sio.printf("\tsse_cc: %d\n", i[:sse_cc]) if i[:sse_cc].nonzero?
    sio.printf("\tavx_cc: %d\n", i[:avx_cc]) if i[:avx_cc].nonzero?
    sio.printf("\tavx_sae: True\n") if i[:avx_sae]
    sio.printf("\tavx_rm: %d\n", i[:avx_rm]) if i[:avx_rm].nonzero?

    if i.reads_reg?(:eax) || i.reads_reg?(19) || i.reads_reg?(REG_EAX)
      print '[eax:r] '
      unless i.reads_reg?(:eax) && i.reads_reg?('eax') && i.reads_reg?(19) && i.reads_reg?(REG_EAX)
        raise 'Error in reg read decomposition'
      end
    end

    if i.writes_reg?('eax') || i.writes_reg?(19) || i.writes_reg?(REG_EAX)
      print '[eax:w] '
      unless i.writes_reg?('eax') && i.writes_reg?(19) && i.writes_reg?(REG_EAX)
        raise 'Error in reg write decomposition'
      end
    end

    if (count = i.op_count(OP_IMM)).nonzero?
      sio.puts "\timm_count: #{count}"
      i.operands.select(&:imm?).each_with_index do |op, j|
        sio.puts "\t\timms[#{j + 1}]: 0x#{uint64(op.value).to_s(16)}"
      end
    end

    if i.op_count > 0
      sio.puts "\top_count: #{i.op_count}"
      i.operands.each_with_index do |op, c|
        if op.reg?
          sio.puts "\t\toperands[#{c}].type: REG = #{cs.reg_name(op.value)}"
        elsif op.imm?
          sio.puts "\t\toperands[#{c}].type: IMM = 0x#{uint64(op.value).to_s(16)}"
        elsif op.fp?
          sio.puts "\t\toperands[#{c}].type: FP = 0x#{uint32(op.value)}"
        elsif op.mem?
          sio.puts "\t\toperands[#{c}].type: MEM"
          if op.value[:segment].nonzero?
            sio.puts format("\t\t\toperands[#{c}].mem.segment: REG = %s", cs.reg_name(op.value[:segment]))
          end
          if op.value[:base].nonzero?
            sio.puts format("\t\t\toperands[#{c}].mem.base: REG = %s", cs.reg_name(op.value[:base]))
          end
          if op.value[:index].nonzero?
            sio.puts format("\t\t\toperands[#{c}].mem.index: REG = %s", cs.reg_name(op.value[:index]))
          end
          sio.puts format("\t\t\toperands[#{c}].mem.scale: %u", op.value[:scale]) if op.value[:scale] != 1
          sio.puts format("\t\t\toperands[#{c}].mem.disp: 0x%x", uint64(op.value[:disp])) if op.value[:disp].nonzero?
        end

        sio.printf("\t\toperands[#{c}].avx_bcast: %u\n", op[:avx_bcast]) if op[:avx_bcast].nonzero?
        sio.printf("\t\toperands[#{c}].avx_zero_opmask: TRUE\n") if op[:avx_zero_opmask]
        sio.printf("\t\toperands[#{c}].size: %u\n", op[:size])
      end
    end

    sio.puts
  end

  ours = StringIO.new

  # Test through all modes and architectures
  begin
    cs = Disassembler.new(0, 0)
    print "X86 Test: Capstone v #{cs.version.join('.')} - "
  ensure
    cs.close
  end
  @platforms.each do |p|
    ours.puts '****************'
    ours.puts "Platform: #{p['comment']}"
    ours.puts "Code:#{p['code'].bytes.map { |b| format('0x%.2x', b) }.join(' ')} "
    ours.puts 'Disasm:'

    cs = Disassembler.new(p['arch'], p['mode'])
    cs.decomposer = true
    cs.syntax = p['syntax'] if p['syntax']
    cache = nil

    # This form is NOT RECOMMENDED in real code except as a last resort - use
    # the block form if possible.
    insns = cs.disasm(p['code'], 0x1000)

    insns.each do |insn|
      ours.puts "0x#{insn.address.to_s(16)}:\t#{insn.mnemonic}\t#{insn.op_str}"
      print_detail(cs, insn, cs.mode, ours)
      cache = insn
    end
    ours.printf("0x%x:\n", cache.address + cache.size)
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
