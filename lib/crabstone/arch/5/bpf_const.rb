# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'crabstone/arch/register'

module Crabstone
  module BPF
    OP_INVALID = 0
    OP_REG = 1
    OP_IMM = 2
    OP_OFF = 3
    OP_MEM = 4
    OP_MMEM = 5
    OP_MSH = 6
    OP_EXT = 7

    REG_INVALID = 0
    REG_A = 1
    REG_X = 2
    REG_R0 = 3
    REG_R1 = 4
    REG_R2 = 5
    REG_R3 = 6
    REG_R4 = 7
    REG_R5 = 8
    REG_R6 = 9
    REG_R7 = 10
    REG_R8 = 11
    REG_R9 = 12
    REG_R10 = 13
    REG_ENDING = 14

    EXT_INVALID = 0
    EXT_LEN = 1

    INS_INVALID = 0
    INS_ADD = 1
    INS_SUB = 2
    INS_MUL = 3
    INS_DIV = 4
    INS_OR = 5
    INS_AND = 6
    INS_LSH = 7
    INS_RSH = 8
    INS_NEG = 9
    INS_MOD = 10
    INS_XOR = 11
    INS_MOV = 12
    INS_ARSH = 13
    INS_ADD64 = 14
    INS_SUB64 = 15
    INS_MUL64 = 16
    INS_DIV64 = 17
    INS_OR64 = 18
    INS_AND64 = 19
    INS_LSH64 = 20
    INS_RSH64 = 21
    INS_NEG64 = 22
    INS_MOD64 = 23
    INS_XOR64 = 24
    INS_MOV64 = 25
    INS_ARSH64 = 26
    INS_LE16 = 27
    INS_LE32 = 28
    INS_LE64 = 29
    INS_BE16 = 30
    INS_BE32 = 31
    INS_BE64 = 32
    INS_LDW = 33
    INS_LDH = 34
    INS_LDB = 35
    INS_LDDW = 36
    INS_LDXW = 37
    INS_LDXH = 38
    INS_LDXB = 39
    INS_LDXDW = 40
    INS_STW = 41
    INS_STH = 42
    INS_STB = 43
    INS_STDW = 44
    INS_STXW = 45
    INS_STXH = 46
    INS_STXB = 47
    INS_STXDW = 48
    INS_XADDW = 49
    INS_XADDDW = 50
    INS_JMP = 51
    INS_JEQ = 52
    INS_JGT = 53
    INS_JGE = 54
    INS_JSET = 55
    INS_JNE = 56
    INS_JSGT = 57
    INS_JSGE = 58
    INS_CALL = 59
    INS_CALLX = 60
    INS_EXIT = 61
    INS_JLT = 62
    INS_JLE = 63
    INS_JSLT = 64
    INS_JSLE = 65
    INS_RET = 66
    INS_TAX = 67
    INS_TXA = 68
    INS_ENDING = 69
    INS_LD = INS_LDW
    INS_LDX = INS_LDXW
    INS_ST = INS_STW
    INS_STX = INS_STXW

    GRP_INVALID = 0
    GRP_LOAD = 1
    GRP_STORE = 2
    GRP_ALU = 3
    GRP_JUMP = 4
    GRP_CALL = 5
    GRP_RETURN = 6
    GRP_MISC = 7
    GRP_ENDING = 8

    extend Register
  end
end
