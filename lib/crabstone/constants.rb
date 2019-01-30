# TODO: Auto-gerneate this file.
# Constants in this file might be added in a newer Capstone version,
# but I expect they are always backward compatible.
module Crabstone
  # API version
  BINDING_MAJ = 3
  BINDING_MIN = 0

  # architectures
  ARCH_ARM   = 0
  ARCH_ARM64 = 1
  ARCH_MIPS  = 2
  ARCH_X86   = 3
  ARCH_PPC   = 4
  ARCH_SPARC = 5
  ARCH_SYSZ  = 6
  ARCH_XCORE = 7
  ARCH_MAX   = 8
  ARCH_ALL   = 0xFFFF

  # disasm mode
  MODE_LITTLE_ENDIAN = 0       # little-endian mode (default mode)
  MODE_ARM           = 0       # 32-bit ARM
  MODE_16            = 1 << 1  # 16-bit mode (X86)
  MODE_32            = 1 << 2  # 32-bit mode (X86)
  MODE_64            = 1 << 3  # 64-bit mode (X86, PPC)
  MODE_THUMB         = 1 << 4  # ARM's Thumb mode, including Thumb-2
  MODE_MCLASS        = 1 << 5  # ARM's Cortex-M series
  MODE_V8            = 1 << 6  # ARMv8 A32 encodings for ARM
  MODE_MICRO         = 1 << 4  # MicroMips mode (MIPS)
  MODE_MIPS3         = 1 << 5  # Mips III ISA
  MODE_MIPS32R6      = 1 << 6  # Mips32r6 ISA
  MODE_MIPSGP64      = 1 << 7  # General Purpose Registers are 64-bit wide (MIPS)
  MODE_V9            = 1 << 4  # SparcV9 mode (Sparc)
  MODE_BIG_ENDIAN    = 1 << 31 # big-endian mode
  MODE_MIPS32        = MODE_32 # Mips32 ISA (Mips)
  MODE_MIPS64        = MODE_64 # Mips64 ISA (Mips)

  # Capstone option type
  OPT_SYNTAX         = 1  # Intel X86 asm syntax (ARCH_X86 arch)
  OPT_DETAIL         = 2  # Break down instruction structure into details
  OPT_MODE           = 3  # Change engine's mode at run-time
  OPT_MEM            = 4  # Change engine's mode at run-time
  OPT_SKIPDATA       = 5  # Skip data when disassembling
  OPT_SKIPDATA_SETUP = 6  # Setup user-defined function for SKIPDATA option

  # Capstone option value
  OPT_OFF = 0 # Turn OFF an option - default option of OPT_DETAIL
  OPT_ON  = 3 # Turn ON an option (OPT_DETAIL)

  # Common instruction operand types - to be consistent across all architectures.
  OP_INVALID = 0
  OP_REG     = 1
  OP_IMM     = 2
  OP_MEM     = 3
  OP_FP      = 4

  # Common instruction groups - to be consistent across all architectures.
  GRP_INVALID = 0  # uninitialized/invalid group.
  GRP_JUMP    = 1  # all jump instructions (conditional+direct+indirect jumps)
  GRP_CALL    = 2  # all call instructions
  GRP_RET     = 3  # all return instructions
  GRP_INT     = 4  # all interrupt instructions (int+syscall)
  GRP_IRET    = 5  # all interrupt return instructions

  # Capstone syntax value
  OPT_SYNTAX_DEFAULT   = 0  # Default assembly syntax of all platforms (OPT_SYNTAX)
  OPT_SYNTAX_INTEL     = 1  # Intel X86 asm syntax - default syntax on X86 (OPT_SYNTAX, ARCH_X86)
  OPT_SYNTAX_ATT       = 2  # ATT asm syntax (OPT_SYNTAX, ARCH_X86)
  OPT_SYNTAX_NOREGNAME = 3  # Asm syntax prints register name with only number - (OPT_SYNTAX, ARCH_PPC, ARCH_ARM)

  # query id for cs_support()
  SUPPORT_DIET       = ARCH_ALL + 1
  SUPPORT_X86_REDUCE = ARCH_ALL + 2
end
