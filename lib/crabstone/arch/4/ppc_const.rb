# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'crabstone/arch/register'

module Crabstone
  module PPC
    BC_INVALID = 0
    BC_LT = (0 << 5) | 12
    BC_LE = (1 << 5) | 4
    BC_EQ = (2 << 5) | 12
    BC_GE = (0 << 5) | 4
    BC_GT = (1 << 5) | 12
    BC_NE = (2 << 5) | 4
    BC_UN = (3 << 5) | 12
    BC_NU = (3 << 5) | 4
    BC_SO = (4 << 5) | 12
    BC_NS = (4 << 5) | 4

    BH_INVALID = 0
    BH_PLUS = 1
    BH_MINUS = 2

    OP_INVALID = 0
    OP_REG = 1
    OP_IMM = 2
    OP_MEM = 3
    OP_CRX = 64

    REG_INVALID = 0
    REG_CARRY = 1
    REG_CR0 = 2
    REG_CR1 = 3
    REG_CR2 = 4
    REG_CR3 = 5
    REG_CR4 = 6
    REG_CR5 = 7
    REG_CR6 = 8
    REG_CR7 = 9
    REG_CTR = 10
    REG_F0 = 11
    REG_F1 = 12
    REG_F2 = 13
    REG_F3 = 14
    REG_F4 = 15
    REG_F5 = 16
    REG_F6 = 17
    REG_F7 = 18
    REG_F8 = 19
    REG_F9 = 20
    REG_F10 = 21
    REG_F11 = 22
    REG_F12 = 23
    REG_F13 = 24
    REG_F14 = 25
    REG_F15 = 26
    REG_F16 = 27
    REG_F17 = 28
    REG_F18 = 29
    REG_F19 = 30
    REG_F20 = 31
    REG_F21 = 32
    REG_F22 = 33
    REG_F23 = 34
    REG_F24 = 35
    REG_F25 = 36
    REG_F26 = 37
    REG_F27 = 38
    REG_F28 = 39
    REG_F29 = 40
    REG_F30 = 41
    REG_F31 = 42
    REG_LR = 43
    REG_R0 = 44
    REG_R1 = 45
    REG_R2 = 46
    REG_R3 = 47
    REG_R4 = 48
    REG_R5 = 49
    REG_R6 = 50
    REG_R7 = 51
    REG_R8 = 52
    REG_R9 = 53
    REG_R10 = 54
    REG_R11 = 55
    REG_R12 = 56
    REG_R13 = 57
    REG_R14 = 58
    REG_R15 = 59
    REG_R16 = 60
    REG_R17 = 61
    REG_R18 = 62
    REG_R19 = 63
    REG_R20 = 64
    REG_R21 = 65
    REG_R22 = 66
    REG_R23 = 67
    REG_R24 = 68
    REG_R25 = 69
    REG_R26 = 70
    REG_R27 = 71
    REG_R28 = 72
    REG_R29 = 73
    REG_R30 = 74
    REG_R31 = 75
    REG_V0 = 76
    REG_V1 = 77
    REG_V2 = 78
    REG_V3 = 79
    REG_V4 = 80
    REG_V5 = 81
    REG_V6 = 82
    REG_V7 = 83
    REG_V8 = 84
    REG_V9 = 85
    REG_V10 = 86
    REG_V11 = 87
    REG_V12 = 88
    REG_V13 = 89
    REG_V14 = 90
    REG_V15 = 91
    REG_V16 = 92
    REG_V17 = 93
    REG_V18 = 94
    REG_V19 = 95
    REG_V20 = 96
    REG_V21 = 97
    REG_V22 = 98
    REG_V23 = 99
    REG_V24 = 100
    REG_V25 = 101
    REG_V26 = 102
    REG_V27 = 103
    REG_V28 = 104
    REG_V29 = 105
    REG_V30 = 106
    REG_V31 = 107
    REG_VRSAVE = 108
    REG_VS0 = 109
    REG_VS1 = 110
    REG_VS2 = 111
    REG_VS3 = 112
    REG_VS4 = 113
    REG_VS5 = 114
    REG_VS6 = 115
    REG_VS7 = 116
    REG_VS8 = 117
    REG_VS9 = 118
    REG_VS10 = 119
    REG_VS11 = 120
    REG_VS12 = 121
    REG_VS13 = 122
    REG_VS14 = 123
    REG_VS15 = 124
    REG_VS16 = 125
    REG_VS17 = 126
    REG_VS18 = 127
    REG_VS19 = 128
    REG_VS20 = 129
    REG_VS21 = 130
    REG_VS22 = 131
    REG_VS23 = 132
    REG_VS24 = 133
    REG_VS25 = 134
    REG_VS26 = 135
    REG_VS27 = 136
    REG_VS28 = 137
    REG_VS29 = 138
    REG_VS30 = 139
    REG_VS31 = 140
    REG_VS32 = 141
    REG_VS33 = 142
    REG_VS34 = 143
    REG_VS35 = 144
    REG_VS36 = 145
    REG_VS37 = 146
    REG_VS38 = 147
    REG_VS39 = 148
    REG_VS40 = 149
    REG_VS41 = 150
    REG_VS42 = 151
    REG_VS43 = 152
    REG_VS44 = 153
    REG_VS45 = 154
    REG_VS46 = 155
    REG_VS47 = 156
    REG_VS48 = 157
    REG_VS49 = 158
    REG_VS50 = 159
    REG_VS51 = 160
    REG_VS52 = 161
    REG_VS53 = 162
    REG_VS54 = 163
    REG_VS55 = 164
    REG_VS56 = 165
    REG_VS57 = 166
    REG_VS58 = 167
    REG_VS59 = 168
    REG_VS60 = 169
    REG_VS61 = 170
    REG_VS62 = 171
    REG_VS63 = 172
    REG_Q0 = 173
    REG_Q1 = 174
    REG_Q2 = 175
    REG_Q3 = 176
    REG_Q4 = 177
    REG_Q5 = 178
    REG_Q6 = 179
    REG_Q7 = 180
    REG_Q8 = 181
    REG_Q9 = 182
    REG_Q10 = 183
    REG_Q11 = 184
    REG_Q12 = 185
    REG_Q13 = 186
    REG_Q14 = 187
    REG_Q15 = 188
    REG_Q16 = 189
    REG_Q17 = 190
    REG_Q18 = 191
    REG_Q19 = 192
    REG_Q20 = 193
    REG_Q21 = 194
    REG_Q22 = 195
    REG_Q23 = 196
    REG_Q24 = 197
    REG_Q25 = 198
    REG_Q26 = 199
    REG_Q27 = 200
    REG_Q28 = 201
    REG_Q29 = 202
    REG_Q30 = 203
    REG_Q31 = 204
    REG_RM = 205
    REG_CTR8 = 206
    REG_LR8 = 207
    REG_CR1EQ = 208
    REG_X2 = 209
    REG_ENDING = 210

    INS_INVALID = 0
    INS_ADD = 1
    INS_ADDC = 2
    INS_ADDE = 3
    INS_ADDI = 4
    INS_ADDIC = 5
    INS_ADDIS = 6
    INS_ADDME = 7
    INS_ADDZE = 8
    INS_AND = 9
    INS_ANDC = 10
    INS_ANDIS = 11
    INS_ANDI = 12
    INS_ATTN = 13
    INS_B = 14
    INS_BA = 15
    INS_BC = 16
    INS_BCCTR = 17
    INS_BCCTRL = 18
    INS_BCL = 19
    INS_BCLR = 20
    INS_BCLRL = 21
    INS_BCTR = 22
    INS_BCTRL = 23
    INS_BCT = 24
    INS_BDNZ = 25
    INS_BDNZA = 26
    INS_BDNZL = 27
    INS_BDNZLA = 28
    INS_BDNZLR = 29
    INS_BDNZLRL = 30
    INS_BDZ = 31
    INS_BDZA = 32
    INS_BDZL = 33
    INS_BDZLA = 34
    INS_BDZLR = 35
    INS_BDZLRL = 36
    INS_BL = 37
    INS_BLA = 38
    INS_BLR = 39
    INS_BLRL = 40
    INS_BRINC = 41
    INS_CMPB = 42
    INS_CMPD = 43
    INS_CMPDI = 44
    INS_CMPLD = 45
    INS_CMPLDI = 46
    INS_CMPLW = 47
    INS_CMPLWI = 48
    INS_CMPW = 49
    INS_CMPWI = 50
    INS_CNTLZD = 51
    INS_CNTLZW = 52
    INS_CREQV = 53
    INS_CRXOR = 54
    INS_CRAND = 55
    INS_CRANDC = 56
    INS_CRNAND = 57
    INS_CRNOR = 58
    INS_CROR = 59
    INS_CRORC = 60
    INS_DCBA = 61
    INS_DCBF = 62
    INS_DCBI = 63
    INS_DCBST = 64
    INS_DCBT = 65
    INS_DCBTST = 66
    INS_DCBZ = 67
    INS_DCBZL = 68
    INS_DCCCI = 69
    INS_DIVD = 70
    INS_DIVDU = 71
    INS_DIVW = 72
    INS_DIVWU = 73
    INS_DSS = 74
    INS_DSSALL = 75
    INS_DST = 76
    INS_DSTST = 77
    INS_DSTSTT = 78
    INS_DSTT = 79
    INS_EQV = 80
    INS_EVABS = 81
    INS_EVADDIW = 82
    INS_EVADDSMIAAW = 83
    INS_EVADDSSIAAW = 84
    INS_EVADDUMIAAW = 85
    INS_EVADDUSIAAW = 86
    INS_EVADDW = 87
    INS_EVAND = 88
    INS_EVANDC = 89
    INS_EVCMPEQ = 90
    INS_EVCMPGTS = 91
    INS_EVCMPGTU = 92
    INS_EVCMPLTS = 93
    INS_EVCMPLTU = 94
    INS_EVCNTLSW = 95
    INS_EVCNTLZW = 96
    INS_EVDIVWS = 97
    INS_EVDIVWU = 98
    INS_EVEQV = 99
    INS_EVEXTSB = 100
    INS_EVEXTSH = 101
    INS_EVLDD = 102
    INS_EVLDDX = 103
    INS_EVLDH = 104
    INS_EVLDHX = 105
    INS_EVLDW = 106
    INS_EVLDWX = 107
    INS_EVLHHESPLAT = 108
    INS_EVLHHESPLATX = 109
    INS_EVLHHOSSPLAT = 110
    INS_EVLHHOSSPLATX = 111
    INS_EVLHHOUSPLAT = 112
    INS_EVLHHOUSPLATX = 113
    INS_EVLWHE = 114
    INS_EVLWHEX = 115
    INS_EVLWHOS = 116
    INS_EVLWHOSX = 117
    INS_EVLWHOU = 118
    INS_EVLWHOUX = 119
    INS_EVLWHSPLAT = 120
    INS_EVLWHSPLATX = 121
    INS_EVLWWSPLAT = 122
    INS_EVLWWSPLATX = 123
    INS_EVMERGEHI = 124
    INS_EVMERGEHILO = 125
    INS_EVMERGELO = 126
    INS_EVMERGELOHI = 127
    INS_EVMHEGSMFAA = 128
    INS_EVMHEGSMFAN = 129
    INS_EVMHEGSMIAA = 130
    INS_EVMHEGSMIAN = 131
    INS_EVMHEGUMIAA = 132
    INS_EVMHEGUMIAN = 133
    INS_EVMHESMF = 134
    INS_EVMHESMFA = 135
    INS_EVMHESMFAAW = 136
    INS_EVMHESMFANW = 137
    INS_EVMHESMI = 138
    INS_EVMHESMIA = 139
    INS_EVMHESMIAAW = 140
    INS_EVMHESMIANW = 141
    INS_EVMHESSF = 142
    INS_EVMHESSFA = 143
    INS_EVMHESSFAAW = 144
    INS_EVMHESSFANW = 145
    INS_EVMHESSIAAW = 146
    INS_EVMHESSIANW = 147
    INS_EVMHEUMI = 148
    INS_EVMHEUMIA = 149
    INS_EVMHEUMIAAW = 150
    INS_EVMHEUMIANW = 151
    INS_EVMHEUSIAAW = 152
    INS_EVMHEUSIANW = 153
    INS_EVMHOGSMFAA = 154
    INS_EVMHOGSMFAN = 155
    INS_EVMHOGSMIAA = 156
    INS_EVMHOGSMIAN = 157
    INS_EVMHOGUMIAA = 158
    INS_EVMHOGUMIAN = 159
    INS_EVMHOSMF = 160
    INS_EVMHOSMFA = 161
    INS_EVMHOSMFAAW = 162
    INS_EVMHOSMFANW = 163
    INS_EVMHOSMI = 164
    INS_EVMHOSMIA = 165
    INS_EVMHOSMIAAW = 166
    INS_EVMHOSMIANW = 167
    INS_EVMHOSSF = 168
    INS_EVMHOSSFA = 169
    INS_EVMHOSSFAAW = 170
    INS_EVMHOSSFANW = 171
    INS_EVMHOSSIAAW = 172
    INS_EVMHOSSIANW = 173
    INS_EVMHOUMI = 174
    INS_EVMHOUMIA = 175
    INS_EVMHOUMIAAW = 176
    INS_EVMHOUMIANW = 177
    INS_EVMHOUSIAAW = 178
    INS_EVMHOUSIANW = 179
    INS_EVMRA = 180
    INS_EVMWHSMF = 181
    INS_EVMWHSMFA = 182
    INS_EVMWHSMI = 183
    INS_EVMWHSMIA = 184
    INS_EVMWHSSF = 185
    INS_EVMWHSSFA = 186
    INS_EVMWHUMI = 187
    INS_EVMWHUMIA = 188
    INS_EVMWLSMIAAW = 189
    INS_EVMWLSMIANW = 190
    INS_EVMWLSSIAAW = 191
    INS_EVMWLSSIANW = 192
    INS_EVMWLUMI = 193
    INS_EVMWLUMIA = 194
    INS_EVMWLUMIAAW = 195
    INS_EVMWLUMIANW = 196
    INS_EVMWLUSIAAW = 197
    INS_EVMWLUSIANW = 198
    INS_EVMWSMF = 199
    INS_EVMWSMFA = 200
    INS_EVMWSMFAA = 201
    INS_EVMWSMFAN = 202
    INS_EVMWSMI = 203
    INS_EVMWSMIA = 204
    INS_EVMWSMIAA = 205
    INS_EVMWSMIAN = 206
    INS_EVMWSSF = 207
    INS_EVMWSSFA = 208
    INS_EVMWSSFAA = 209
    INS_EVMWSSFAN = 210
    INS_EVMWUMI = 211
    INS_EVMWUMIA = 212
    INS_EVMWUMIAA = 213
    INS_EVMWUMIAN = 214
    INS_EVNAND = 215
    INS_EVNEG = 216
    INS_EVNOR = 217
    INS_EVOR = 218
    INS_EVORC = 219
    INS_EVRLW = 220
    INS_EVRLWI = 221
    INS_EVRNDW = 222
    INS_EVSLW = 223
    INS_EVSLWI = 224
    INS_EVSPLATFI = 225
    INS_EVSPLATI = 226
    INS_EVSRWIS = 227
    INS_EVSRWIU = 228
    INS_EVSRWS = 229
    INS_EVSRWU = 230
    INS_EVSTDD = 231
    INS_EVSTDDX = 232
    INS_EVSTDH = 233
    INS_EVSTDHX = 234
    INS_EVSTDW = 235
    INS_EVSTDWX = 236
    INS_EVSTWHE = 237
    INS_EVSTWHEX = 238
    INS_EVSTWHO = 239
    INS_EVSTWHOX = 240
    INS_EVSTWWE = 241
    INS_EVSTWWEX = 242
    INS_EVSTWWO = 243
    INS_EVSTWWOX = 244
    INS_EVSUBFSMIAAW = 245
    INS_EVSUBFSSIAAW = 246
    INS_EVSUBFUMIAAW = 247
    INS_EVSUBFUSIAAW = 248
    INS_EVSUBFW = 249
    INS_EVSUBIFW = 250
    INS_EVXOR = 251
    INS_EXTSB = 252
    INS_EXTSH = 253
    INS_EXTSW = 254
    INS_EIEIO = 255
    INS_FABS = 256
    INS_FADD = 257
    INS_FADDS = 258
    INS_FCFID = 259
    INS_FCFIDS = 260
    INS_FCFIDU = 261
    INS_FCFIDUS = 262
    INS_FCMPU = 263
    INS_FCPSGN = 264
    INS_FCTID = 265
    INS_FCTIDUZ = 266
    INS_FCTIDZ = 267
    INS_FCTIW = 268
    INS_FCTIWUZ = 269
    INS_FCTIWZ = 270
    INS_FDIV = 271
    INS_FDIVS = 272
    INS_FMADD = 273
    INS_FMADDS = 274
    INS_FMR = 275
    INS_FMSUB = 276
    INS_FMSUBS = 277
    INS_FMUL = 278
    INS_FMULS = 279
    INS_FNABS = 280
    INS_FNEG = 281
    INS_FNMADD = 282
    INS_FNMADDS = 283
    INS_FNMSUB = 284
    INS_FNMSUBS = 285
    INS_FRE = 286
    INS_FRES = 287
    INS_FRIM = 288
    INS_FRIN = 289
    INS_FRIP = 290
    INS_FRIZ = 291
    INS_FRSP = 292
    INS_FRSQRTE = 293
    INS_FRSQRTES = 294
    INS_FSEL = 295
    INS_FSQRT = 296
    INS_FSQRTS = 297
    INS_FSUB = 298
    INS_FSUBS = 299
    INS_ICBI = 300
    INS_ICBT = 301
    INS_ICCCI = 302
    INS_ISEL = 303
    INS_ISYNC = 304
    INS_LA = 305
    INS_LBZ = 306
    INS_LBZCIX = 307
    INS_LBZU = 308
    INS_LBZUX = 309
    INS_LBZX = 310
    INS_LD = 311
    INS_LDARX = 312
    INS_LDBRX = 313
    INS_LDCIX = 314
    INS_LDU = 315
    INS_LDUX = 316
    INS_LDX = 317
    INS_LFD = 318
    INS_LFDU = 319
    INS_LFDUX = 320
    INS_LFDX = 321
    INS_LFIWAX = 322
    INS_LFIWZX = 323
    INS_LFS = 324
    INS_LFSU = 325
    INS_LFSUX = 326
    INS_LFSX = 327
    INS_LHA = 328
    INS_LHAU = 329
    INS_LHAUX = 330
    INS_LHAX = 331
    INS_LHBRX = 332
    INS_LHZ = 333
    INS_LHZCIX = 334
    INS_LHZU = 335
    INS_LHZUX = 336
    INS_LHZX = 337
    INS_LI = 338
    INS_LIS = 339
    INS_LMW = 340
    INS_LSWI = 341
    INS_LVEBX = 342
    INS_LVEHX = 343
    INS_LVEWX = 344
    INS_LVSL = 345
    INS_LVSR = 346
    INS_LVX = 347
    INS_LVXL = 348
    INS_LWA = 349
    INS_LWARX = 350
    INS_LWAUX = 351
    INS_LWAX = 352
    INS_LWBRX = 353
    INS_LWZ = 354
    INS_LWZCIX = 355
    INS_LWZU = 356
    INS_LWZUX = 357
    INS_LWZX = 358
    INS_LXSDX = 359
    INS_LXVD2X = 360
    INS_LXVDSX = 361
    INS_LXVW4X = 362
    INS_MBAR = 363
    INS_MCRF = 364
    INS_MCRFS = 365
    INS_MFCR = 366
    INS_MFCTR = 367
    INS_MFDCR = 368
    INS_MFFS = 369
    INS_MFLR = 370
    INS_MFMSR = 371
    INS_MFOCRF = 372
    INS_MFSPR = 373
    INS_MFSR = 374
    INS_MFSRIN = 375
    INS_MFTB = 376
    INS_MFVSCR = 377
    INS_MSYNC = 378
    INS_MTCRF = 379
    INS_MTCTR = 380
    INS_MTDCR = 381
    INS_MTFSB0 = 382
    INS_MTFSB1 = 383
    INS_MTFSF = 384
    INS_MTFSFI = 385
    INS_MTLR = 386
    INS_MTMSR = 387
    INS_MTMSRD = 388
    INS_MTOCRF = 389
    INS_MTSPR = 390
    INS_MTSR = 391
    INS_MTSRIN = 392
    INS_MTVSCR = 393
    INS_MULHD = 394
    INS_MULHDU = 395
    INS_MULHW = 396
    INS_MULHWU = 397
    INS_MULLD = 398
    INS_MULLI = 399
    INS_MULLW = 400
    INS_NAND = 401
    INS_NEG = 402
    INS_NOP = 403
    INS_ORI = 404
    INS_NOR = 405
    INS_OR = 406
    INS_ORC = 407
    INS_ORIS = 408
    INS_POPCNTD = 409
    INS_POPCNTW = 410
    INS_QVALIGNI = 411
    INS_QVESPLATI = 412
    INS_QVFABS = 413
    INS_QVFADD = 414
    INS_QVFADDS = 415
    INS_QVFCFID = 416
    INS_QVFCFIDS = 417
    INS_QVFCFIDU = 418
    INS_QVFCFIDUS = 419
    INS_QVFCMPEQ = 420
    INS_QVFCMPGT = 421
    INS_QVFCMPLT = 422
    INS_QVFCPSGN = 423
    INS_QVFCTID = 424
    INS_QVFCTIDU = 425
    INS_QVFCTIDUZ = 426
    INS_QVFCTIDZ = 427
    INS_QVFCTIW = 428
    INS_QVFCTIWU = 429
    INS_QVFCTIWUZ = 430
    INS_QVFCTIWZ = 431
    INS_QVFLOGICAL = 432
    INS_QVFMADD = 433
    INS_QVFMADDS = 434
    INS_QVFMR = 435
    INS_QVFMSUB = 436
    INS_QVFMSUBS = 437
    INS_QVFMUL = 438
    INS_QVFMULS = 439
    INS_QVFNABS = 440
    INS_QVFNEG = 441
    INS_QVFNMADD = 442
    INS_QVFNMADDS = 443
    INS_QVFNMSUB = 444
    INS_QVFNMSUBS = 445
    INS_QVFPERM = 446
    INS_QVFRE = 447
    INS_QVFRES = 448
    INS_QVFRIM = 449
    INS_QVFRIN = 450
    INS_QVFRIP = 451
    INS_QVFRIZ = 452
    INS_QVFRSP = 453
    INS_QVFRSQRTE = 454
    INS_QVFRSQRTES = 455
    INS_QVFSEL = 456
    INS_QVFSUB = 457
    INS_QVFSUBS = 458
    INS_QVFTSTNAN = 459
    INS_QVFXMADD = 460
    INS_QVFXMADDS = 461
    INS_QVFXMUL = 462
    INS_QVFXMULS = 463
    INS_QVFXXCPNMADD = 464
    INS_QVFXXCPNMADDS = 465
    INS_QVFXXMADD = 466
    INS_QVFXXMADDS = 467
    INS_QVFXXNPMADD = 468
    INS_QVFXXNPMADDS = 469
    INS_QVGPCI = 470
    INS_QVLFCDUX = 471
    INS_QVLFCDUXA = 472
    INS_QVLFCDX = 473
    INS_QVLFCDXA = 474
    INS_QVLFCSUX = 475
    INS_QVLFCSUXA = 476
    INS_QVLFCSX = 477
    INS_QVLFCSXA = 478
    INS_QVLFDUX = 479
    INS_QVLFDUXA = 480
    INS_QVLFDX = 481
    INS_QVLFDXA = 482
    INS_QVLFIWAX = 483
    INS_QVLFIWAXA = 484
    INS_QVLFIWZX = 485
    INS_QVLFIWZXA = 486
    INS_QVLFSUX = 487
    INS_QVLFSUXA = 488
    INS_QVLFSX = 489
    INS_QVLFSXA = 490
    INS_QVLPCLDX = 491
    INS_QVLPCLSX = 492
    INS_QVLPCRDX = 493
    INS_QVLPCRSX = 494
    INS_QVSTFCDUX = 495
    INS_QVSTFCDUXA = 496
    INS_QVSTFCDUXI = 497
    INS_QVSTFCDUXIA = 498
    INS_QVSTFCDX = 499
    INS_QVSTFCDXA = 500
    INS_QVSTFCDXI = 501
    INS_QVSTFCDXIA = 502
    INS_QVSTFCSUX = 503
    INS_QVSTFCSUXA = 504
    INS_QVSTFCSUXI = 505
    INS_QVSTFCSUXIA = 506
    INS_QVSTFCSX = 507
    INS_QVSTFCSXA = 508
    INS_QVSTFCSXI = 509
    INS_QVSTFCSXIA = 510
    INS_QVSTFDUX = 511
    INS_QVSTFDUXA = 512
    INS_QVSTFDUXI = 513
    INS_QVSTFDUXIA = 514
    INS_QVSTFDX = 515
    INS_QVSTFDXA = 516
    INS_QVSTFDXI = 517
    INS_QVSTFDXIA = 518
    INS_QVSTFIWX = 519
    INS_QVSTFIWXA = 520
    INS_QVSTFSUX = 521
    INS_QVSTFSUXA = 522
    INS_QVSTFSUXI = 523
    INS_QVSTFSUXIA = 524
    INS_QVSTFSX = 525
    INS_QVSTFSXA = 526
    INS_QVSTFSXI = 527
    INS_QVSTFSXIA = 528
    INS_RFCI = 529
    INS_RFDI = 530
    INS_RFI = 531
    INS_RFID = 532
    INS_RFMCI = 533
    INS_RLDCL = 534
    INS_RLDCR = 535
    INS_RLDIC = 536
    INS_RLDICL = 537
    INS_RLDICR = 538
    INS_RLDIMI = 539
    INS_RLWIMI = 540
    INS_RLWINM = 541
    INS_RLWNM = 542
    INS_SC = 543
    INS_SLBIA = 544
    INS_SLBIE = 545
    INS_SLBMFEE = 546
    INS_SLBMTE = 547
    INS_SLD = 548
    INS_SLW = 549
    INS_SRAD = 550
    INS_SRADI = 551
    INS_SRAW = 552
    INS_SRAWI = 553
    INS_SRD = 554
    INS_SRW = 555
    INS_STB = 556
    INS_STBCIX = 557
    INS_STBU = 558
    INS_STBUX = 559
    INS_STBX = 560
    INS_STD = 561
    INS_STDBRX = 562
    INS_STDCIX = 563
    INS_STDCX = 564
    INS_STDU = 565
    INS_STDUX = 566
    INS_STDX = 567
    INS_STFD = 568
    INS_STFDU = 569
    INS_STFDUX = 570
    INS_STFDX = 571
    INS_STFIWX = 572
    INS_STFS = 573
    INS_STFSU = 574
    INS_STFSUX = 575
    INS_STFSX = 576
    INS_STH = 577
    INS_STHBRX = 578
    INS_STHCIX = 579
    INS_STHU = 580
    INS_STHUX = 581
    INS_STHX = 582
    INS_STMW = 583
    INS_STSWI = 584
    INS_STVEBX = 585
    INS_STVEHX = 586
    INS_STVEWX = 587
    INS_STVX = 588
    INS_STVXL = 589
    INS_STW = 590
    INS_STWBRX = 591
    INS_STWCIX = 592
    INS_STWCX = 593
    INS_STWU = 594
    INS_STWUX = 595
    INS_STWX = 596
    INS_STXSDX = 597
    INS_STXVD2X = 598
    INS_STXVW4X = 599
    INS_SUBF = 600
    INS_SUBFC = 601
    INS_SUBFE = 602
    INS_SUBFIC = 603
    INS_SUBFME = 604
    INS_SUBFZE = 605
    INS_SYNC = 606
    INS_TD = 607
    INS_TDI = 608
    INS_TLBIA = 609
    INS_TLBIE = 610
    INS_TLBIEL = 611
    INS_TLBIVAX = 612
    INS_TLBLD = 613
    INS_TLBLI = 614
    INS_TLBRE = 615
    INS_TLBSX = 616
    INS_TLBSYNC = 617
    INS_TLBWE = 618
    INS_TRAP = 619
    INS_TW = 620
    INS_TWI = 621
    INS_VADDCUW = 622
    INS_VADDFP = 623
    INS_VADDSBS = 624
    INS_VADDSHS = 625
    INS_VADDSWS = 626
    INS_VADDUBM = 627
    INS_VADDUBS = 628
    INS_VADDUDM = 629
    INS_VADDUHM = 630
    INS_VADDUHS = 631
    INS_VADDUWM = 632
    INS_VADDUWS = 633
    INS_VAND = 634
    INS_VANDC = 635
    INS_VAVGSB = 636
    INS_VAVGSH = 637
    INS_VAVGSW = 638
    INS_VAVGUB = 639
    INS_VAVGUH = 640
    INS_VAVGUW = 641
    INS_VCFSX = 642
    INS_VCFUX = 643
    INS_VCLZB = 644
    INS_VCLZD = 645
    INS_VCLZH = 646
    INS_VCLZW = 647
    INS_VCMPBFP = 648
    INS_VCMPEQFP = 649
    INS_VCMPEQUB = 650
    INS_VCMPEQUD = 651
    INS_VCMPEQUH = 652
    INS_VCMPEQUW = 653
    INS_VCMPGEFP = 654
    INS_VCMPGTFP = 655
    INS_VCMPGTSB = 656
    INS_VCMPGTSD = 657
    INS_VCMPGTSH = 658
    INS_VCMPGTSW = 659
    INS_VCMPGTUB = 660
    INS_VCMPGTUD = 661
    INS_VCMPGTUH = 662
    INS_VCMPGTUW = 663
    INS_VCTSXS = 664
    INS_VCTUXS = 665
    INS_VEQV = 666
    INS_VEXPTEFP = 667
    INS_VLOGEFP = 668
    INS_VMADDFP = 669
    INS_VMAXFP = 670
    INS_VMAXSB = 671
    INS_VMAXSD = 672
    INS_VMAXSH = 673
    INS_VMAXSW = 674
    INS_VMAXUB = 675
    INS_VMAXUD = 676
    INS_VMAXUH = 677
    INS_VMAXUW = 678
    INS_VMHADDSHS = 679
    INS_VMHRADDSHS = 680
    INS_VMINUD = 681
    INS_VMINFP = 682
    INS_VMINSB = 683
    INS_VMINSD = 684
    INS_VMINSH = 685
    INS_VMINSW = 686
    INS_VMINUB = 687
    INS_VMINUH = 688
    INS_VMINUW = 689
    INS_VMLADDUHM = 690
    INS_VMRGHB = 691
    INS_VMRGHH = 692
    INS_VMRGHW = 693
    INS_VMRGLB = 694
    INS_VMRGLH = 695
    INS_VMRGLW = 696
    INS_VMSUMMBM = 697
    INS_VMSUMSHM = 698
    INS_VMSUMSHS = 699
    INS_VMSUMUBM = 700
    INS_VMSUMUHM = 701
    INS_VMSUMUHS = 702
    INS_VMULESB = 703
    INS_VMULESH = 704
    INS_VMULESW = 705
    INS_VMULEUB = 706
    INS_VMULEUH = 707
    INS_VMULEUW = 708
    INS_VMULOSB = 709
    INS_VMULOSH = 710
    INS_VMULOSW = 711
    INS_VMULOUB = 712
    INS_VMULOUH = 713
    INS_VMULOUW = 714
    INS_VMULUWM = 715
    INS_VNAND = 716
    INS_VNMSUBFP = 717
    INS_VNOR = 718
    INS_VOR = 719
    INS_VORC = 720
    INS_VPERM = 721
    INS_VPKPX = 722
    INS_VPKSHSS = 723
    INS_VPKSHUS = 724
    INS_VPKSWSS = 725
    INS_VPKSWUS = 726
    INS_VPKUHUM = 727
    INS_VPKUHUS = 728
    INS_VPKUWUM = 729
    INS_VPKUWUS = 730
    INS_VPOPCNTB = 731
    INS_VPOPCNTD = 732
    INS_VPOPCNTH = 733
    INS_VPOPCNTW = 734
    INS_VREFP = 735
    INS_VRFIM = 736
    INS_VRFIN = 737
    INS_VRFIP = 738
    INS_VRFIZ = 739
    INS_VRLB = 740
    INS_VRLD = 741
    INS_VRLH = 742
    INS_VRLW = 743
    INS_VRSQRTEFP = 744
    INS_VSEL = 745
    INS_VSL = 746
    INS_VSLB = 747
    INS_VSLD = 748
    INS_VSLDOI = 749
    INS_VSLH = 750
    INS_VSLO = 751
    INS_VSLW = 752
    INS_VSPLTB = 753
    INS_VSPLTH = 754
    INS_VSPLTISB = 755
    INS_VSPLTISH = 756
    INS_VSPLTISW = 757
    INS_VSPLTW = 758
    INS_VSR = 759
    INS_VSRAB = 760
    INS_VSRAD = 761
    INS_VSRAH = 762
    INS_VSRAW = 763
    INS_VSRB = 764
    INS_VSRD = 765
    INS_VSRH = 766
    INS_VSRO = 767
    INS_VSRW = 768
    INS_VSUBCUW = 769
    INS_VSUBFP = 770
    INS_VSUBSBS = 771
    INS_VSUBSHS = 772
    INS_VSUBSWS = 773
    INS_VSUBUBM = 774
    INS_VSUBUBS = 775
    INS_VSUBUDM = 776
    INS_VSUBUHM = 777
    INS_VSUBUHS = 778
    INS_VSUBUWM = 779
    INS_VSUBUWS = 780
    INS_VSUM2SWS = 781
    INS_VSUM4SBS = 782
    INS_VSUM4SHS = 783
    INS_VSUM4UBS = 784
    INS_VSUMSWS = 785
    INS_VUPKHPX = 786
    INS_VUPKHSB = 787
    INS_VUPKHSH = 788
    INS_VUPKLPX = 789
    INS_VUPKLSB = 790
    INS_VUPKLSH = 791
    INS_VXOR = 792
    INS_WAIT = 793
    INS_WRTEE = 794
    INS_WRTEEI = 795
    INS_XOR = 796
    INS_XORI = 797
    INS_XORIS = 798
    INS_XSABSDP = 799
    INS_XSADDDP = 800
    INS_XSCMPODP = 801
    INS_XSCMPUDP = 802
    INS_XSCPSGNDP = 803
    INS_XSCVDPSP = 804
    INS_XSCVDPSXDS = 805
    INS_XSCVDPSXWS = 806
    INS_XSCVDPUXDS = 807
    INS_XSCVDPUXWS = 808
    INS_XSCVSPDP = 809
    INS_XSCVSXDDP = 810
    INS_XSCVUXDDP = 811
    INS_XSDIVDP = 812
    INS_XSMADDADP = 813
    INS_XSMADDMDP = 814
    INS_XSMAXDP = 815
    INS_XSMINDP = 816
    INS_XSMSUBADP = 817
    INS_XSMSUBMDP = 818
    INS_XSMULDP = 819
    INS_XSNABSDP = 820
    INS_XSNEGDP = 821
    INS_XSNMADDADP = 822
    INS_XSNMADDMDP = 823
    INS_XSNMSUBADP = 824
    INS_XSNMSUBMDP = 825
    INS_XSRDPI = 826
    INS_XSRDPIC = 827
    INS_XSRDPIM = 828
    INS_XSRDPIP = 829
    INS_XSRDPIZ = 830
    INS_XSREDP = 831
    INS_XSRSQRTEDP = 832
    INS_XSSQRTDP = 833
    INS_XSSUBDP = 834
    INS_XSTDIVDP = 835
    INS_XSTSQRTDP = 836
    INS_XVABSDP = 837
    INS_XVABSSP = 838
    INS_XVADDDP = 839
    INS_XVADDSP = 840
    INS_XVCMPEQDP = 841
    INS_XVCMPEQSP = 842
    INS_XVCMPGEDP = 843
    INS_XVCMPGESP = 844
    INS_XVCMPGTDP = 845
    INS_XVCMPGTSP = 846
    INS_XVCPSGNDP = 847
    INS_XVCPSGNSP = 848
    INS_XVCVDPSP = 849
    INS_XVCVDPSXDS = 850
    INS_XVCVDPSXWS = 851
    INS_XVCVDPUXDS = 852
    INS_XVCVDPUXWS = 853
    INS_XVCVSPDP = 854
    INS_XVCVSPSXDS = 855
    INS_XVCVSPSXWS = 856
    INS_XVCVSPUXDS = 857
    INS_XVCVSPUXWS = 858
    INS_XVCVSXDDP = 859
    INS_XVCVSXDSP = 860
    INS_XVCVSXWDP = 861
    INS_XVCVSXWSP = 862
    INS_XVCVUXDDP = 863
    INS_XVCVUXDSP = 864
    INS_XVCVUXWDP = 865
    INS_XVCVUXWSP = 866
    INS_XVDIVDP = 867
    INS_XVDIVSP = 868
    INS_XVMADDADP = 869
    INS_XVMADDASP = 870
    INS_XVMADDMDP = 871
    INS_XVMADDMSP = 872
    INS_XVMAXDP = 873
    INS_XVMAXSP = 874
    INS_XVMINDP = 875
    INS_XVMINSP = 876
    INS_XVMSUBADP = 877
    INS_XVMSUBASP = 878
    INS_XVMSUBMDP = 879
    INS_XVMSUBMSP = 880
    INS_XVMULDP = 881
    INS_XVMULSP = 882
    INS_XVNABSDP = 883
    INS_XVNABSSP = 884
    INS_XVNEGDP = 885
    INS_XVNEGSP = 886
    INS_XVNMADDADP = 887
    INS_XVNMADDASP = 888
    INS_XVNMADDMDP = 889
    INS_XVNMADDMSP = 890
    INS_XVNMSUBADP = 891
    INS_XVNMSUBASP = 892
    INS_XVNMSUBMDP = 893
    INS_XVNMSUBMSP = 894
    INS_XVRDPI = 895
    INS_XVRDPIC = 896
    INS_XVRDPIM = 897
    INS_XVRDPIP = 898
    INS_XVRDPIZ = 899
    INS_XVREDP = 900
    INS_XVRESP = 901
    INS_XVRSPI = 902
    INS_XVRSPIC = 903
    INS_XVRSPIM = 904
    INS_XVRSPIP = 905
    INS_XVRSPIZ = 906
    INS_XVRSQRTEDP = 907
    INS_XVRSQRTESP = 908
    INS_XVSQRTDP = 909
    INS_XVSQRTSP = 910
    INS_XVSUBDP = 911
    INS_XVSUBSP = 912
    INS_XVTDIVDP = 913
    INS_XVTDIVSP = 914
    INS_XVTSQRTDP = 915
    INS_XVTSQRTSP = 916
    INS_XXLAND = 917
    INS_XXLANDC = 918
    INS_XXLEQV = 919
    INS_XXLNAND = 920
    INS_XXLNOR = 921
    INS_XXLOR = 922
    INS_XXLORC = 923
    INS_XXLXOR = 924
    INS_XXMRGHW = 925
    INS_XXMRGLW = 926
    INS_XXPERMDI = 927
    INS_XXSEL = 928
    INS_XXSLDWI = 929
    INS_XXSPLTW = 930
    INS_BCA = 931
    INS_BCLA = 932
    INS_SLWI = 933
    INS_SRWI = 934
    INS_SLDI = 935
    INS_BTA = 936
    INS_CRSET = 937
    INS_CRNOT = 938
    INS_CRMOVE = 939
    INS_CRCLR = 940
    INS_MFBR0 = 941
    INS_MFBR1 = 942
    INS_MFBR2 = 943
    INS_MFBR3 = 944
    INS_MFBR4 = 945
    INS_MFBR5 = 946
    INS_MFBR6 = 947
    INS_MFBR7 = 948
    INS_MFXER = 949
    INS_MFRTCU = 950
    INS_MFRTCL = 951
    INS_MFDSCR = 952
    INS_MFDSISR = 953
    INS_MFDAR = 954
    INS_MFSRR2 = 955
    INS_MFSRR3 = 956
    INS_MFCFAR = 957
    INS_MFAMR = 958
    INS_MFPID = 959
    INS_MFTBLO = 960
    INS_MFTBHI = 961
    INS_MFDBATU = 962
    INS_MFDBATL = 963
    INS_MFIBATU = 964
    INS_MFIBATL = 965
    INS_MFDCCR = 966
    INS_MFICCR = 967
    INS_MFDEAR = 968
    INS_MFESR = 969
    INS_MFSPEFSCR = 970
    INS_MFTCR = 971
    INS_MFASR = 972
    INS_MFPVR = 973
    INS_MFTBU = 974
    INS_MTCR = 975
    INS_MTBR0 = 976
    INS_MTBR1 = 977
    INS_MTBR2 = 978
    INS_MTBR3 = 979
    INS_MTBR4 = 980
    INS_MTBR5 = 981
    INS_MTBR6 = 982
    INS_MTBR7 = 983
    INS_MTXER = 984
    INS_MTDSCR = 985
    INS_MTDSISR = 986
    INS_MTDAR = 987
    INS_MTSRR2 = 988
    INS_MTSRR3 = 989
    INS_MTCFAR = 990
    INS_MTAMR = 991
    INS_MTPID = 992
    INS_MTTBL = 993
    INS_MTTBU = 994
    INS_MTTBLO = 995
    INS_MTTBHI = 996
    INS_MTDBATU = 997
    INS_MTDBATL = 998
    INS_MTIBATU = 999
    INS_MTIBATL = 1000
    INS_MTDCCR = 1001
    INS_MTICCR = 1002
    INS_MTDEAR = 1003
    INS_MTESR = 1004
    INS_MTSPEFSCR = 1005
    INS_MTTCR = 1006
    INS_NOT = 1007
    INS_MR = 1008
    INS_ROTLD = 1009
    INS_ROTLDI = 1010
    INS_CLRLDI = 1011
    INS_ROTLWI = 1012
    INS_CLRLWI = 1013
    INS_ROTLW = 1014
    INS_SUB = 1015
    INS_SUBC = 1016
    INS_LWSYNC = 1017
    INS_PTESYNC = 1018
    INS_TDLT = 1019
    INS_TDEQ = 1020
    INS_TDGT = 1021
    INS_TDNE = 1022
    INS_TDLLT = 1023
    INS_TDLGT = 1024
    INS_TDU = 1025
    INS_TDLTI = 1026
    INS_TDEQI = 1027
    INS_TDGTI = 1028
    INS_TDNEI = 1029
    INS_TDLLTI = 1030
    INS_TDLGTI = 1031
    INS_TDUI = 1032
    INS_TLBREHI = 1033
    INS_TLBRELO = 1034
    INS_TLBWEHI = 1035
    INS_TLBWELO = 1036
    INS_TWLT = 1037
    INS_TWEQ = 1038
    INS_TWGT = 1039
    INS_TWNE = 1040
    INS_TWLLT = 1041
    INS_TWLGT = 1042
    INS_TWU = 1043
    INS_TWLTI = 1044
    INS_TWEQI = 1045
    INS_TWGTI = 1046
    INS_TWNEI = 1047
    INS_TWLLTI = 1048
    INS_TWLGTI = 1049
    INS_TWUI = 1050
    INS_WAITRSV = 1051
    INS_WAITIMPL = 1052
    INS_XNOP = 1053
    INS_XVMOVDP = 1054
    INS_XVMOVSP = 1055
    INS_XXSPLTD = 1056
    INS_XXMRGHD = 1057
    INS_XXMRGLD = 1058
    INS_XXSWAPD = 1059
    INS_BT = 1060
    INS_BF = 1061
    INS_BDNZT = 1062
    INS_BDNZF = 1063
    INS_BDZF = 1064
    INS_BDZT = 1065
    INS_BFA = 1066
    INS_BDNZTA = 1067
    INS_BDNZFA = 1068
    INS_BDZTA = 1069
    INS_BDZFA = 1070
    INS_BTCTR = 1071
    INS_BFCTR = 1072
    INS_BTCTRL = 1073
    INS_BFCTRL = 1074
    INS_BTL = 1075
    INS_BFL = 1076
    INS_BDNZTL = 1077
    INS_BDNZFL = 1078
    INS_BDZTL = 1079
    INS_BDZFL = 1080
    INS_BTLA = 1081
    INS_BFLA = 1082
    INS_BDNZTLA = 1083
    INS_BDNZFLA = 1084
    INS_BDZTLA = 1085
    INS_BDZFLA = 1086
    INS_BTLR = 1087
    INS_BFLR = 1088
    INS_BDNZTLR = 1089
    INS_BDZTLR = 1090
    INS_BDZFLR = 1091
    INS_BTLRL = 1092
    INS_BFLRL = 1093
    INS_BDNZTLRL = 1094
    INS_BDNZFLRL = 1095
    INS_BDZTLRL = 1096
    INS_BDZFLRL = 1097
    INS_QVFAND = 1098
    INS_QVFCLR = 1099
    INS_QVFANDC = 1100
    INS_QVFCTFB = 1101
    INS_QVFXOR = 1102
    INS_QVFOR = 1103
    INS_QVFNOR = 1104
    INS_QVFEQU = 1105
    INS_QVFNOT = 1106
    INS_QVFORC = 1107
    INS_QVFNAND = 1108
    INS_QVFSET = 1109
    INS_ENDING = 1110

    GRP_INVALID = 0
    GRP_JUMP = 1
    GRP_ALTIVEC = 128
    GRP_MODE32 = 129
    GRP_MODE64 = 130
    GRP_BOOKE = 131
    GRP_NOTBOOKE = 132
    GRP_SPE = 133
    GRP_VSX = 134
    GRP_E500 = 135
    GRP_PPC4XX = 136
    GRP_PPC6XX = 137
    GRP_ICBT = 138
    GRP_P8ALTIVEC = 139
    GRP_P8VECTOR = 140
    GRP_QPX = 141
    GRP_ENDING = 142

    extend Register
  end
end
