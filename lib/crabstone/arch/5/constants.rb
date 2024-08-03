# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

module Crabstone
  API_MAJOR = 5
  API_MINOR = 0

  VERSION_MAJOR = API_MAJOR
  VERSION_MINOR = API_MINOR
  VERSION_EXTRA = 1

  ARCH_ARM = 0
  ARCH_ARM64 = 1
  ARCH_MIPS = 2
  ARCH_X86 = 3
  ARCH_PPC = 4
  ARCH_SPARC = 5
  ARCH_SYSZ = 6
  ARCH_XCORE = 7
  ARCH_M68K = 8
  ARCH_TMS320C64X = 9
  ARCH_M680X = 10
  ARCH_EVM = 11
  ARCH_MOS65XX = 12
  ARCH_WASM = 13
  ARCH_BPF = 14
  ARCH_RISCV = 15
  ARCH_SH = 16
  ARCH_TRICORE = 17
  ARCH_MAX = 18
  ARCH_ALL = 0xFFFF

  MODE_LITTLE_ENDIAN = 0      # little-endian mode (default mode)
  MODE_ARM = 0                # ARM mode
  MODE_16 = (1 << 1)          # 16-bit mode (for X86)
  MODE_32 = (1 << 2)          # 32-bit mode (for X86)
  MODE_64 = (1 << 3)          # 64-bit mode (for X86, PPC)
  MODE_THUMB = (1 << 4)       # ARM's Thumb mode, including Thumb-2
  MODE_MCLASS = (1 << 5)      # ARM's Cortex-M series
  MODE_V8 = (1 << 6)          # ARMv8 A32 encodings for ARM
  MODE_MICRO = (1 << 4)       # MicroMips mode (MIPS architecture)
  MODE_MIPS3 = (1 << 5)       # Mips III ISA
  MODE_MIPS32R6 = (1 << 6)    # Mips32r6 ISA
  MODE_MIPS2 = (1 << 7)       # Mips II ISA
  MODE_V9 = (1 << 4)          # Sparc V9 mode (for Sparc)
  MODE_QPX = (1 << 4)         # Quad Processing eXtensions mode (PPC)
  MODE_SPE = (1 << 5)         # Signal Processing Engine mode (PPC)
  MODE_BOOKE = (1 << 6)       # Book-E mode (PPC)
  MODE_PS = (1 << 7)          # Paired-singles mode (PPC)
  MODE_M68K_000 = (1 << 1)    # M68K 68000 mode
  MODE_M68K_010 = (1 << 2)    # M68K 68010 mode
  MODE_M68K_020 = (1 << 3)    # M68K 68020 mode
  MODE_M68K_030 = (1 << 4)    # M68K 68030 mode
  MODE_M68K_040 = (1 << 5)    # M68K 68040 mode
  MODE_M68K_060 = (1 << 6)    # M68K 68060 mode
  MODE_BIG_ENDIAN = (1 << 31) # big-endian mode
  MODE_MIPS32 = MODE_32    # Mips32 ISA
  MODE_MIPS64 = MODE_64    # Mips64 ISA
  MODE_M680X_6301 = (1 << 1)  # M680X HD6301/3 mode
  MODE_M680X_6309 = (1 << 2)  # M680X HD6309 mode
  MODE_M680X_6800 = (1 << 3)  # M680X M6800/2 mode
  MODE_M680X_6801 = (1 << 4)  # M680X M6801/3 mode
  MODE_M680X_6805 = (1 << 5)  # M680X M6805 mode
  MODE_M680X_6808 = (1 << 6)  # M680X M68HC08 mode
  MODE_M680X_6809 = (1 << 7)  # M680X M6809 mode
  MODE_M680X_6811 = (1 << 8)  # M680X M68HC11 mode
  MODE_M680X_CPU12 = (1 << 9) # M680X CPU12 mode
  MODE_M680X_HCS08 = (1 << 10)  # M680X HCS08 mode
  MODE_BPF_CLASSIC = 0          # Classic BPF mode (default)
  MODE_BPF_EXTENDED = (1 << 0)  # Extended BPF mode
  MODE_RISCV32 = (1 << 0)       # RISCV32 mode
  MODE_RISCV64 = (1 << 1)       # RISCV64 mode
  MODE_RISCVC  = (1 << 2)       # RISCV compressed mode
  MODE_MOS65XX_6502 = (1 << 1) # MOS65XXX MOS 6502
  MODE_MOS65XX_65C02 = (1 << 2) # MOS65XXX WDC 65c02
  MODE_MOS65XX_W65C02 = (1 << 3) # MOS65XXX WDC W65c02
  MODE_MOS65XX_65816 = (1 << 4) # MOS65XXX WDC 65816, 8-bit m/x
  MODE_MOS65XX_65816_LONG_M = (1 << 5) # MOS65XXX WDC 65816, 16-bit m, 8-bit x
  MODE_MOS65XX_65816_LONG_X = (1 << 6) # MOS65XXX WDC 65816, 8-bit m, 16-bit x
  MODE_MOS65XX_65816_LONG_MX = MODE_MOS65XX_65816_LONG_M | MODE_MOS65XX_65816_LONG_X
  MODE_SH2 = 1 << 1   # SH2
  MODE_SH2A = 1 << 2  # SH2A
  MODE_SH3 = 1 << 3   # SH3
  MODE_SH4 = 1 << 4   # SH4
  MODE_SH4A = 1 << 5  # SH4A
  MODE_SHFPU = 1 << 6 # w/ FPU
  MODE_SHDSP = 1 << 7 # w/ DSP
  MODE_TRICORE_110 = 1 << 1 # Tricore 1.1
  MODE_TRICORE_120 = 1 << 2 # Tricore 1.2
  MODE_TRICORE_130 = 1 << 3 # Tricore 1.3
  MODE_TRICORE_131 = 1 << 4 # Tricore 1.3.1
  MODE_TRICORE_160 = 1 << 5 # Tricore 1.6
  MODE_TRICORE_161 = 1 << 6 # Tricore 1.6.1
  MODE_TRICORE_162 = 1 << 7 # Tricore 1.6.2

  OPT_INVALID = 0   # No option specified
  OPT_SYNTAX = 1    # Intel X86 asm syntax (ARCH_X86 arch)
  OPT_DETAIL = 2    # Break down instruction structure into details
  OPT_MODE = 3      # Change engine's mode at run-time
  OPT_MEM = 4       # Change engine's mode at run-time
  OPT_SKIPDATA = 5  # Skip data when disassembling
  OPT_SKIPDATA_SETUP = 6 # Setup user-defined function for SKIPDATA option
  OPT_MNEMONIC = 7  # Customize instruction mnemonic
  OPT_UNSIGNED = 8  # Print immediate in unsigned form
  OPT_NO_BRANCH_OFFSET = 9 # ARM, prints branch immediates without offset.

  OPT_OFF = 0             # Turn OFF an option - default option of OPT_DETAIL
  OPT_ON = 3              # Turn ON an option (OPT_DETAIL)

  OP_INVALID = 0 # uninitialized/invalid operand.
  OP_REG = 1  # Register operand.
  OP_IMM = 2  # Immediate operand.
  OP_MEM = 3  # Memory operand. Can be ORed with another operand type.
  OP_FP  = 4  # Floating-Point operand.

  GRP_INVALID = 0  # uninitialized/invalid group.
  GRP_JUMP    = 1  # all jump instructions (conditional+direct+indirect jumps)
  GRP_CALL    = 2  # all call instructions
  GRP_RET     = 3  # all return instructions
  GRP_INT     = 4  # all interrupt instructions (int+syscall)
  GRP_IRET    = 5  # all interrupt return instructions
  GRP_PRIVILEGE = 6 # all privileged instructions
  GRP_BRANCH_RELATIVE = 7 # all relative branching instructions

  AC_INVALID  = 0        # Invalid/unitialized access type.
  AC_READ     = (1 << 0) # Operand that is read from.
  AC_WRITE    = (1 << 1) # Operand that is written to.

  OPT_SYNTAX_DEFAULT = 0 # Default assembly syntax of all platforms (OPT_SYNTAX)
  OPT_SYNTAX_INTEL = 1    # Intel X86 asm syntax - default syntax on X86 (OPT_SYNTAX, ARCH_X86)
  OPT_SYNTAX_ATT = 2      # ATT asm syntax (OPT_SYNTAX, ARCH_X86)
  OPT_SYNTAX_NOREGNAME = 3 # Asm syntax prints register name with only number - (OPT_SYNTAX, ARCH_PPC, ARCH_ARM)
  OPT_SYNTAX_MASM = 4 # MASM syntax (OPT_SYNTAX, ARCH_X86)
  OPT_SYNTAX_MOTOROLA = 5 # MOS65XX use $ as hex prefix

  ERR_OK = 0      # No error: everything was fine
  ERR_MEM = 1     # Out-Of-Memory error: cs_open(), cs_disasm()
  ERR_ARCH = 2    # Unsupported architecture: cs_open()
  ERR_HANDLE = 3  # Invalid handle: cs_op_count(), cs_op_index()
  ERR_CSH = 4     # Invalid csh argument: cs_close(), cs_errno(), cs_option()
  ERR_MODE = 5    # Invalid/unsupported mode: cs_open()
  ERR_OPTION = 6  # Invalid/unsupported option: cs_option()
  ERR_DETAIL = 7  # Invalid/unsupported option: cs_option()
  ERR_MEMSETUP = 8
  ERR_VERSION = 9 # Unsupported version (bindings)
  ERR_DIET = 10   # Information irrelevant in diet engine
  ERR_SKIPDATA = 11 # Access irrelevant data for "data" instruction in SKIPDATA mode
  ERR_X86_ATT = 12 # X86 AT&T syntax is unsupported (opt-out at compile time)
  ERR_X86_INTEL = 13 # X86 Intel syntax is unsupported (opt-out at compile time)
  ERR_X86_MASM = 14 # X86 Intel syntax is unsupported (opt-out at compile time)

  SUPPORT_DIET = ARCH_ALL + 1
  SUPPORT_X86_REDUCE = ARCH_ALL + 2
end
