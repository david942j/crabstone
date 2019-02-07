[![Gem Version](https://badge.fury.io/rb/crabstone.svg)](https://badge.fury.io/rb/crabstone)
[![Build Status](https://travis-ci.org/david942j/crabstone.svg?branch=master)](https://travis-ci.org/david942j/crabstone)
[![Issue Count](https://codeclimate.com/github/david942j/crabstone/badges/issue_count.svg)](https://codeclimate.com/github/david942j/crabstone)
[![Test Coverage](https://codeclimate.com/github/david942j/crabstone/badges/coverage.svg)](https://codeclimate.com/github/david942j/crabstone/coverage)

crabstone
====

Current library support: Capstone 3 \& 4
----

( FROM THE CAPSTONE README )

Capstone is a disassembly framework with the target of becoming the ultimate
disasm engine for binary analysis and reversing in the security community.

Created by Nguyen Anh Quynh, then developed and maintained by a small community,
Capstone offers some unparalleled features:

- Support multiple hardware architectures: ARM, ARM64 (ARMv8), Ethereum VM, M68K,
  Mips, MOS65XX, PPC, Sparc, SystemZ, TMS320C64X, M680X, XCore and X86 (including X86_64).

- Having clean/simple/lightweight/intuitive architecture-neutral API.

- Provide details on disassembled instruction (called “decomposer” by others).

- Provide semantics of the disassembled instruction, such as list of implicit
  registers read & written.

- Implemented in pure C language, with lightweight bindings for D, Clojure, F#,
  Common Lisp, Visual Basic, PHP, PowerShell, Emacs, Haskell, Perl, Python,
  Ruby, C#, NodeJS, Java, GO, C++, OCaml, Lua, Rust, Delphi, Free Pascal & Vala
  ready either in main code, or provided externally by the community.

- Native support for all popular platforms: Windows, Mac OSX, iOS, Android,
  Linux, \*BSD, Solaris, etc.

- Thread-safe by design.

- Special support for embedding into firmware or OS kernel.

- High performance & suitable for malware analysis (capable of handling various
  X86 malware tricks).

- Distributed under the open source BSD license.

To install:
----

First install the capstone library from either https://github.com/aquynh/capstone
or http://www.capstone-engine.org

Then:

```bash
gem install crabstone
```

To write code:
----

Check the tests in [Capstone](https://github.com/aquynh/capstone) for more examples. Here is "Hello World":
```ruby

require 'crabstone'
include Crabstone
arm =
  "\xED\xFF\xFF\xEB\x04\xe0\x2d\xe5\x00\x00\x00\x00\xe0\x83\x22" \
  "\xe5\xf1\x02\x03\x0e\x00\x00\xa0\xe3\x02\x30\xc1\xe7\x00\x00\x53\xe3"

begin
  cs = Disassembler.new(ARCH_ARM, MODE_ARM)
  puts "Hello from Capstone v#{cs.version.join('.')}!"
  puts 'Disasm:'

  begin
    cs.disasm(arm, 0x1000).each do |i|
      printf("0x%x:\t%s\t\t%s\n", i.address, i.mnemonic, i.op_str)
    end
  rescue StandardError => e
    raise "Disassembly error: #{e.message}"
  ensure
    cs.close
  end
rescue StandardError => e
  raise "Unable to open engine: #{e.message}"
end
```

Contributing:
----

If you feel like chipping in, especially with better tests or examples, or (please!!) documentation, fork and send me a pull req.


	Library Author: Nguyen Anh Quynh
	Binding Authors: Nguyen Anh Quynh, Tan Sheng Di, Ben Nagy, david942j
	License: BSD style - details in the LICENSE file
	(c) 2013 COSEINC. All Rights Reserved.

