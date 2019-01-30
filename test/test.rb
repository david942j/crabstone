#!/usr/bin/env ruby

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'crabstone'
require 'stringio'

module Test
  include Crabstone

  X86_CODE16   = "\x8d\x4c\x32\x08\x01\xd8\x81\xc6\x34\x12\x00\x00".freeze
  X86_CODE32   = "\x8d\x4c\x32\x08\x01\xd8\x81\xc6\x34\x12\x00\x00".freeze
  X86_CODE64   = "\x55\x48\x8b\x05\xb8\x13\x00\x00".freeze
  ARM_CODE     = "\xED\xFF\xFF\xEB\x04\xe0\x2d\xe5\x00\x00\x00\x00\xe0\x83\x22\xe5\xf1\x02\x03\x0e\x00\x00\xa0\xe3\x02\x30\xc1\xe7\x00\x00\x53\xe3".freeze
  ARM_CODE2    = "\x10\xf1\x10\xe7\x11\xf2\x31\xe7\xdc\xa1\x2e\xf3\xe8\x4e\x62\xf3".freeze
  ARMV8        = "\xe0\x3b\xb2\xee\x42\x00\x01\xe1\x51\xf0\x7f\xf5".freeze
  THUMB_MCLASS = "\xef\xf3\x02\x80".freeze
  THUMB_CODE   = "\x70\x47\xeb\x46\x83\xb0\xc9\x68".freeze
  THUMB_CODE2  = "\x4f\xf0\x00\x01\xbd\xe8\x00\x88\xd1\xe8\x00\xf0".freeze
  MIPS_CODE    = "\x0C\x10\x00\x97\x00\x00\x00\x00\x24\x02\x00\x0c\x8f\xa2\x00\x00\x34\x21\x34\x56".freeze
  MIPS_CODE2   = "\x56\x34\x21\x34\xc2\x17\x01\x00".freeze
  MIPS_32R6M   = "\x00\x07\x00\x07\x00\x11\x93\x7c\x01\x8c\x8b\x7c\x00\xc7\x48\xd0".freeze
  MIPS_32R6    = "\xec\x80\x00\x19\x7c\x43\x22\xa0".freeze
  ARM64_CODE   = "\x21\x7c\x02\x9b\x21\x7c\x00\x53\x00\x40\x21\x4b\xe1\x0b\x40\xb9".freeze
  PPC_CODE     = "\x80\x20\x00\x00\x80\x3f\x00\x00\x10\x43\x23\x0e\xd0\x44\x00\x80\x4c\x43\x22\x02\x2d\x03\x00\x80\x7c\x43\x20\x14\x7c\x43\x20\x93\x4f\x20\x00\x21\x4c\xc8\x00\x21".freeze
  SPARC_CODE   = "\x80\xa0\x40\x02\x85\xc2\x60\x08\x85\xe8\x20\x01\x81\xe8\x00\x00\x90\x10\x20\x01\xd5\xf6\x10\x16\x21\x00\x00\x0a\x86\x00\x40\x02\x01\x00\x00\x00\x12\xbf\xff\xff\x10\xbf\xff\xff\xa0\x02\x00\x09\x0d\xbf\xff\xff\xd4\x20\x60\x00\xd4\x4e\x00\x16\x2a\xc2\x80\x03".freeze
  SPARCV9_CODE = "\x81\xa8\x0a\x24\x89\xa0\x10\x20\x89\xa0\x1a\x60\x89\xa0\x00\xe0".freeze
  SYSZ_CODE    = "\xed\x00\x00\x00\x00\x1a\x5a\x0f\x1f\xff\xc2\x09\x80\x00\x00\x00\x07\xf7\xeb\x2a\xff\xff\x7f\x57\xe3\x01\xff\xff\x7f\x57\xeb\x00\xf0\x00\x00\x24\xb2\x4f\x00\x78".freeze
  XCORE_CODE   = "\xfe\x0f\xfe\x17\x13\x17\xc6\xfe\xec\x17\x97\xf8\xec\x4f\x1f\xfd\xec\x37\x07\xf2\x45\x5b\xf9\xfa\x02\x06\x1b\x10".freeze

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
      'comment' => 'X86 32bit (ATT syntax)',
      'syntax' => :att,
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
    ],
    Hash[
      'arch' => ARCH_ARM,
      'mode' => MODE_ARM,
      'code' => ARM_CODE,
      'comment' => 'ARM'
    ],
    Hash[
      'arch' => ARCH_ARM,
      'mode' => MODE_THUMB,
      'code' => THUMB_CODE2,
      'comment' => 'THUMB-2'
    ],
    Hash[
      'arch' => ARCH_ARM,
      'mode' => MODE_ARM,
      'code' => ARM_CODE2,
      'comment' => 'ARM: Cortex-A15 + NEON'
    ],
    Hash[
      'arch' => ARCH_ARM,
      'mode' => MODE_THUMB,
      'code' => THUMB_CODE,
      'comment' => 'THUMB'
    ],
    Hash[
      'arch' => ARCH_ARM,
      'mode' => MODE_THUMB + MODE_MCLASS,
      'code' => THUMB_MCLASS,
      'comment' => 'Thumb-MClass'
    ],
    Hash[
  'arch' => ARCH_ARM,
  'mode' => MODE_ARM + MODE_V8,
  'code' => ARMV8,
  'comment' => 'Arm-V8'
],
    Hash[
      'arch' => ARCH_MIPS,
      'mode' => MODE_32 + MODE_BIG_ENDIAN,
      'code' => MIPS_CODE,
      'comment' => 'MIPS-32 (Big-endian)'
    ],
    Hash[
      'arch' => ARCH_MIPS,
      'mode' => MODE_64 + MODE_LITTLE_ENDIAN,
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
],
    Hash[
      'arch' => ARCH_ARM64,
      'mode' => MODE_ARM,
      'code' => ARM64_CODE,
      'comment' => 'ARM-64'
    ],
    Hash[
      'arch' => ARCH_PPC,
      'mode' => MODE_BIG_ENDIAN,
      'code' => PPC_CODE,
      'comment' => 'PPC-64'
    ],
    Hash[
      'arch' => ARCH_PPC,
      'mode' => MODE_BIG_ENDIAN,
      'code' => PPC_CODE,
      'syntax' => :no_regname,
      'comment' => 'PPC-64, print register with number only'
    ],
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
    ],
    Hash[
      'arch' => ARCH_SYSZ,
      'mode' => MODE_BIG_ENDIAN,
      'code' => SYSZ_CODE,
      'comment' => 'SystemZ'
    ],
    Hash[
      'arch' => ARCH_XCORE,
      'mode' => MODE_BIG_ENDIAN,
      'code' => XCORE_CODE,
      'comment' => 'XCore'
    ]
  ]

  ours = StringIO.new

  begin
    cs = Disassembler.new(0, 0)
    puts "Capstone Diet Mode: #{DIET_MODE}"
    print "Basic Test: Capstone v #{cs.version.join('.')} - "
  ensure
    begin
      cs.close
    rescue StandardError
      nil
    end
  end

  # Test through all modes and architectures
  @platforms.each do |p|
    ours.puts '****************'
    ours.puts "Platform: #{p['comment']}"
    ours.puts "Code: #{p['code'].bytes.map { |b| format('0x%.2x', b) }.join(' ')} "
    ours.puts 'Disasm:'
    cs = Disassembler.new(p['arch'], p['mode'])
    cs.syntax = p['syntax'] if p['syntax']
    cache = nil
    cs.disasm(p['code'], 0x1000).each do |insn|
      ours.printf("0x%x:\t%s\t\t%s\n", insn.address, insn.mnemonic, insn.op_str)
      cache = insn.address + insn.size
    end
    ours.printf("0x%x:\n", cache)
    cs.close
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
