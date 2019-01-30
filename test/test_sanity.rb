#!/usr/bin/env ruby
# frozen_string_literal: true

# Library by Nguyen Anh Quynh
# Original binding by Nguyen Anh Quynh and Tan Sheng Di
# Additional binding work by Ben Nagy
# (c) 2013 COSEINC. All Rights Reserved.

require 'crabstone'
require 'stringio'

module Test
  include Crabstone

  # These need to be maintained by hand, but I actually just copy them over
  # from the Go binding. It's just a very quick check to catch developer
  # error.
  # TODO: Work out why I can't get the C constants with ffi/tools/const_generator

  @checks = {
    Crabstone::ARM64 => Hash[
      reg_max: 260,
      ins_max: 452,
      grp_max: 132
    ],
    Crabstone::ARM => Hash[
      reg_max: 111,
      ins_max: 435,
      grp_max: 159
    ],
    Crabstone::MIPS => Hash[
      reg_max: 136,
      ins_max: 586,
      grp_max: 161
    ],
    Crabstone::PPC => Hash[
      reg_max: 178,
      ins_max: 934,
      grp_max: 138
    ],
    Crabstone::Sparc => Hash[
      reg_max: 88,
      ins_max: 279,
      grp_max: 135
    ],
    Crabstone::SysZ => Hash[
      reg_max: 35,
      ins_max: 682,
      grp_max: 133
    ],
    Crabstone::X86 => Hash[
      reg_max: 234,
      ins_max: 1295,
      grp_max: 169
    ],
    Crabstone::XCore => Hash[
      reg_max: 26,
      ins_max: 121,
      grp_max: 2
    ]
  }

  begin
    cs = Disassembler.new(0, 0)
    print "Sanity Check: Capstone v #{cs.version.join('.')}\n"
  ensure
    begin
      cs.close
    rescue StandardError
      nil
    end
  end

  # Test through all modes and architectures
  @checks.each do |klass, checklist|
    if klass::REG_ENDING != checklist[:reg_max] ||
       klass::INS_ENDING != checklist[:ins_max] ||
       klass::GRP_ENDING != checklist[:grp_max]
      puts "\t#{__FILE__}: #{klass}: FAIL"
    else
      puts "\t#{__FILE__}: #{klass}: PASS"
    end
  end
end
