# frozen_string_literal: true

# THIS FILE WAS AUTO-GENERATED -- DO NOT EDIT!

require 'crabstone/arch/register'

module Crabstone
  module SysZ
    CC_INVALID = 0
    CC_O = 1
    CC_H = 2
    CC_NLE = 3
    CC_L = 4
    CC_NHE = 5
    CC_LH = 6
    CC_NE = 7
    CC_E = 8
    CC_NLH = 9
    CC_HE = 10
    CC_NL = 11
    CC_LE = 12
    CC_NH = 13
    CC_NO = 14

    OP_INVALID = 0
    OP_REG = 1
    OP_IMM = 2
    OP_MEM = 3
    OP_ACREG = 64

    REG_INVALID = 0
    REG_0 = 1
    REG_1 = 2
    REG_2 = 3
    REG_3 = 4
    REG_4 = 5
    REG_5 = 6
    REG_6 = 7
    REG_7 = 8
    REG_8 = 9
    REG_9 = 10
    REG_10 = 11
    REG_11 = 12
    REG_12 = 13
    REG_13 = 14
    REG_14 = 15
    REG_15 = 16
    REG_CC = 17
    REG_F0 = 18
    REG_F1 = 19
    REG_F2 = 20
    REG_F3 = 21
    REG_F4 = 22
    REG_F5 = 23
    REG_F6 = 24
    REG_F7 = 25
    REG_F8 = 26
    REG_F9 = 27
    REG_F10 = 28
    REG_F11 = 29
    REG_F12 = 30
    REG_F13 = 31
    REG_F14 = 32
    REG_F15 = 33
    REG_R0L = 34
    REG_ENDING = 35

    INS_INVALID = 0
    INS_A = 1
    INS_ADB = 2
    INS_ADBR = 3
    INS_AEB = 4
    INS_AEBR = 5
    INS_AFI = 6
    INS_AG = 7
    INS_AGF = 8
    INS_AGFI = 9
    INS_AGFR = 10
    INS_AGHI = 11
    INS_AGHIK = 12
    INS_AGR = 13
    INS_AGRK = 14
    INS_AGSI = 15
    INS_AH = 16
    INS_AHI = 17
    INS_AHIK = 18
    INS_AHY = 19
    INS_AIH = 20
    INS_AL = 21
    INS_ALC = 22
    INS_ALCG = 23
    INS_ALCGR = 24
    INS_ALCR = 25
    INS_ALFI = 26
    INS_ALG = 27
    INS_ALGF = 28
    INS_ALGFI = 29
    INS_ALGFR = 30
    INS_ALGHSIK = 31
    INS_ALGR = 32
    INS_ALGRK = 33
    INS_ALHSIK = 34
    INS_ALR = 35
    INS_ALRK = 36
    INS_ALY = 37
    INS_AR = 38
    INS_ARK = 39
    INS_ASI = 40
    INS_AXBR = 41
    INS_AY = 42
    INS_BCR = 43
    INS_BRC = 44
    INS_BRCL = 45
    INS_CGIJ = 46
    INS_CGRJ = 47
    INS_CIJ = 48
    INS_CLGIJ = 49
    INS_CLGRJ = 50
    INS_CLIJ = 51
    INS_CLRJ = 52
    INS_CRJ = 53
    INS_BER = 54
    INS_JE = 55
    INS_JGE = 56
    INS_LOCE = 57
    INS_LOCGE = 58
    INS_LOCGRE = 59
    INS_LOCRE = 60
    INS_STOCE = 61
    INS_STOCGE = 62
    INS_BHR = 63
    INS_BHER = 64
    INS_JHE = 65
    INS_JGHE = 66
    INS_LOCHE = 67
    INS_LOCGHE = 68
    INS_LOCGRHE = 69
    INS_LOCRHE = 70
    INS_STOCHE = 71
    INS_STOCGHE = 72
    INS_JH = 73
    INS_JGH = 74
    INS_LOCH = 75
    INS_LOCGH = 76
    INS_LOCGRH = 77
    INS_LOCRH = 78
    INS_STOCH = 79
    INS_STOCGH = 80
    INS_CGIJNLH = 81
    INS_CGRJNLH = 82
    INS_CIJNLH = 83
    INS_CLGIJNLH = 84
    INS_CLGRJNLH = 85
    INS_CLIJNLH = 86
    INS_CLRJNLH = 87
    INS_CRJNLH = 88
    INS_CGIJE = 89
    INS_CGRJE = 90
    INS_CIJE = 91
    INS_CLGIJE = 92
    INS_CLGRJE = 93
    INS_CLIJE = 94
    INS_CLRJE = 95
    INS_CRJE = 96
    INS_CGIJNLE = 97
    INS_CGRJNLE = 98
    INS_CIJNLE = 99
    INS_CLGIJNLE = 100
    INS_CLGRJNLE = 101
    INS_CLIJNLE = 102
    INS_CLRJNLE = 103
    INS_CRJNLE = 104
    INS_CGIJH = 105
    INS_CGRJH = 106
    INS_CIJH = 107
    INS_CLGIJH = 108
    INS_CLGRJH = 109
    INS_CLIJH = 110
    INS_CLRJH = 111
    INS_CRJH = 112
    INS_CGIJNL = 113
    INS_CGRJNL = 114
    INS_CIJNL = 115
    INS_CLGIJNL = 116
    INS_CLGRJNL = 117
    INS_CLIJNL = 118
    INS_CLRJNL = 119
    INS_CRJNL = 120
    INS_CGIJHE = 121
    INS_CGRJHE = 122
    INS_CIJHE = 123
    INS_CLGIJHE = 124
    INS_CLGRJHE = 125
    INS_CLIJHE = 126
    INS_CLRJHE = 127
    INS_CRJHE = 128
    INS_CGIJNHE = 129
    INS_CGRJNHE = 130
    INS_CIJNHE = 131
    INS_CLGIJNHE = 132
    INS_CLGRJNHE = 133
    INS_CLIJNHE = 134
    INS_CLRJNHE = 135
    INS_CRJNHE = 136
    INS_CGIJL = 137
    INS_CGRJL = 138
    INS_CIJL = 139
    INS_CLGIJL = 140
    INS_CLGRJL = 141
    INS_CLIJL = 142
    INS_CLRJL = 143
    INS_CRJL = 144
    INS_CGIJNH = 145
    INS_CGRJNH = 146
    INS_CIJNH = 147
    INS_CLGIJNH = 148
    INS_CLGRJNH = 149
    INS_CLIJNH = 150
    INS_CLRJNH = 151
    INS_CRJNH = 152
    INS_CGIJLE = 153
    INS_CGRJLE = 154
    INS_CIJLE = 155
    INS_CLGIJLE = 156
    INS_CLGRJLE = 157
    INS_CLIJLE = 158
    INS_CLRJLE = 159
    INS_CRJLE = 160
    INS_CGIJNE = 161
    INS_CGRJNE = 162
    INS_CIJNE = 163
    INS_CLGIJNE = 164
    INS_CLGRJNE = 165
    INS_CLIJNE = 166
    INS_CLRJNE = 167
    INS_CRJNE = 168
    INS_CGIJLH = 169
    INS_CGRJLH = 170
    INS_CIJLH = 171
    INS_CLGIJLH = 172
    INS_CLGRJLH = 173
    INS_CLIJLH = 174
    INS_CLRJLH = 175
    INS_CRJLH = 176
    INS_BLR = 177
    INS_BLER = 178
    INS_JLE = 179
    INS_JGLE = 180
    INS_LOCLE = 181
    INS_LOCGLE = 182
    INS_LOCGRLE = 183
    INS_LOCRLE = 184
    INS_STOCLE = 185
    INS_STOCGLE = 186
    INS_BLHR = 187
    INS_JLH = 188
    INS_JGLH = 189
    INS_LOCLH = 190
    INS_LOCGLH = 191
    INS_LOCGRLH = 192
    INS_LOCRLH = 193
    INS_STOCLH = 194
    INS_STOCGLH = 195
    INS_JL = 196
    INS_JGL = 197
    INS_LOCL = 198
    INS_LOCGL = 199
    INS_LOCGRL = 200
    INS_LOCRL = 201
    INS_LOC = 202
    INS_LOCG = 203
    INS_LOCGR = 204
    INS_LOCR = 205
    INS_STOCL = 206
    INS_STOCGL = 207
    INS_BNER = 208
    INS_JNE = 209
    INS_JGNE = 210
    INS_LOCNE = 211
    INS_LOCGNE = 212
    INS_LOCGRNE = 213
    INS_LOCRNE = 214
    INS_STOCNE = 215
    INS_STOCGNE = 216
    INS_BNHR = 217
    INS_BNHER = 218
    INS_JNHE = 219
    INS_JGNHE = 220
    INS_LOCNHE = 221
    INS_LOCGNHE = 222
    INS_LOCGRNHE = 223
    INS_LOCRNHE = 224
    INS_STOCNHE = 225
    INS_STOCGNHE = 226
    INS_JNH = 227
    INS_JGNH = 228
    INS_LOCNH = 229
    INS_LOCGNH = 230
    INS_LOCGRNH = 231
    INS_LOCRNH = 232
    INS_STOCNH = 233
    INS_STOCGNH = 234
    INS_BNLR = 235
    INS_BNLER = 236
    INS_JNLE = 237
    INS_JGNLE = 238
    INS_LOCNLE = 239
    INS_LOCGNLE = 240
    INS_LOCGRNLE = 241
    INS_LOCRNLE = 242
    INS_STOCNLE = 243
    INS_STOCGNLE = 244
    INS_BNLHR = 245
    INS_JNLH = 246
    INS_JGNLH = 247
    INS_LOCNLH = 248
    INS_LOCGNLH = 249
    INS_LOCGRNLH = 250
    INS_LOCRNLH = 251
    INS_STOCNLH = 252
    INS_STOCGNLH = 253
    INS_JNL = 254
    INS_JGNL = 255
    INS_LOCNL = 256
    INS_LOCGNL = 257
    INS_LOCGRNL = 258
    INS_LOCRNL = 259
    INS_STOCNL = 260
    INS_STOCGNL = 261
    INS_BNOR = 262
    INS_JNO = 263
    INS_JGNO = 264
    INS_LOCNO = 265
    INS_LOCGNO = 266
    INS_LOCGRNO = 267
    INS_LOCRNO = 268
    INS_STOCNO = 269
    INS_STOCGNO = 270
    INS_BOR = 271
    INS_JO = 272
    INS_JGO = 273
    INS_LOCO = 274
    INS_LOCGO = 275
    INS_LOCGRO = 276
    INS_LOCRO = 277
    INS_STOCO = 278
    INS_STOCGO = 279
    INS_STOC = 280
    INS_STOCG = 281
    INS_BASR = 282
    INS_BR = 283
    INS_BRAS = 284
    INS_BRASL = 285
    INS_J = 286
    INS_JG = 287
    INS_BRCT = 288
    INS_BRCTG = 289
    INS_C = 290
    INS_CDB = 291
    INS_CDBR = 292
    INS_CDFBR = 293
    INS_CDGBR = 294
    INS_CDLFBR = 295
    INS_CDLGBR = 296
    INS_CEB = 297
    INS_CEBR = 298
    INS_CEFBR = 299
    INS_CEGBR = 300
    INS_CELFBR = 301
    INS_CELGBR = 302
    INS_CFDBR = 303
    INS_CFEBR = 304
    INS_CFI = 305
    INS_CFXBR = 306
    INS_CG = 307
    INS_CGDBR = 308
    INS_CGEBR = 309
    INS_CGF = 310
    INS_CGFI = 311
    INS_CGFR = 312
    INS_CGFRL = 313
    INS_CGH = 314
    INS_CGHI = 315
    INS_CGHRL = 316
    INS_CGHSI = 317
    INS_CGR = 318
    INS_CGRL = 319
    INS_CGXBR = 320
    INS_CH = 321
    INS_CHF = 322
    INS_CHHSI = 323
    INS_CHI = 324
    INS_CHRL = 325
    INS_CHSI = 326
    INS_CHY = 327
    INS_CIH = 328
    INS_CL = 329
    INS_CLC = 330
    INS_CLFDBR = 331
    INS_CLFEBR = 332
    INS_CLFHSI = 333
    INS_CLFI = 334
    INS_CLFXBR = 335
    INS_CLG = 336
    INS_CLGDBR = 337
    INS_CLGEBR = 338
    INS_CLGF = 339
    INS_CLGFI = 340
    INS_CLGFR = 341
    INS_CLGFRL = 342
    INS_CLGHRL = 343
    INS_CLGHSI = 344
    INS_CLGR = 345
    INS_CLGRL = 346
    INS_CLGXBR = 347
    INS_CLHF = 348
    INS_CLHHSI = 349
    INS_CLHRL = 350
    INS_CLI = 351
    INS_CLIH = 352
    INS_CLIY = 353
    INS_CLR = 354
    INS_CLRL = 355
    INS_CLST = 356
    INS_CLY = 357
    INS_CPSDR = 358
    INS_CR = 359
    INS_CRL = 360
    INS_CS = 361
    INS_CSG = 362
    INS_CSY = 363
    INS_CXBR = 364
    INS_CXFBR = 365
    INS_CXGBR = 366
    INS_CXLFBR = 367
    INS_CXLGBR = 368
    INS_CY = 369
    INS_DDB = 370
    INS_DDBR = 371
    INS_DEB = 372
    INS_DEBR = 373
    INS_DL = 374
    INS_DLG = 375
    INS_DLGR = 376
    INS_DLR = 377
    INS_DSG = 378
    INS_DSGF = 379
    INS_DSGFR = 380
    INS_DSGR = 381
    INS_DXBR = 382
    INS_EAR = 383
    INS_FIDBR = 384
    INS_FIDBRA = 385
    INS_FIEBR = 386
    INS_FIEBRA = 387
    INS_FIXBR = 388
    INS_FIXBRA = 389
    INS_FLOGR = 390
    INS_IC = 391
    INS_ICY = 392
    INS_IIHF = 393
    INS_IIHH = 394
    INS_IIHL = 395
    INS_IILF = 396
    INS_IILH = 397
    INS_IILL = 398
    INS_IPM = 399
    INS_L = 400
    INS_LA = 401
    INS_LAA = 402
    INS_LAAG = 403
    INS_LAAL = 404
    INS_LAALG = 405
    INS_LAN = 406
    INS_LANG = 407
    INS_LAO = 408
    INS_LAOG = 409
    INS_LARL = 410
    INS_LAX = 411
    INS_LAXG = 412
    INS_LAY = 413
    INS_LB = 414
    INS_LBH = 415
    INS_LBR = 416
    INS_LCDBR = 417
    INS_LCEBR = 418
    INS_LCGFR = 419
    INS_LCGR = 420
    INS_LCR = 421
    INS_LCXBR = 422
    INS_LD = 423
    INS_LDEB = 424
    INS_LDEBR = 425
    INS_LDGR = 426
    INS_LDR = 427
    INS_LDXBR = 428
    INS_LDXBRA = 429
    INS_LDY = 430
    INS_LE = 431
    INS_LEDBR = 432
    INS_LEDBRA = 433
    INS_LER = 434
    INS_LEXBR = 435
    INS_LEXBRA = 436
    INS_LEY = 437
    INS_LFH = 438
    INS_LG = 439
    INS_LGB = 440
    INS_LGBR = 441
    INS_LGDR = 442
    INS_LGF = 443
    INS_LGFI = 444
    INS_LGFR = 445
    INS_LGFRL = 446
    INS_LGH = 447
    INS_LGHI = 448
    INS_LGHR = 449
    INS_LGHRL = 450
    INS_LGR = 451
    INS_LGRL = 452
    INS_LH = 453
    INS_LHH = 454
    INS_LHI = 455
    INS_LHR = 456
    INS_LHRL = 457
    INS_LHY = 458
    INS_LLC = 459
    INS_LLCH = 460
    INS_LLCR = 461
    INS_LLGC = 462
    INS_LLGCR = 463
    INS_LLGF = 464
    INS_LLGFR = 465
    INS_LLGFRL = 466
    INS_LLGH = 467
    INS_LLGHR = 468
    INS_LLGHRL = 469
    INS_LLH = 470
    INS_LLHH = 471
    INS_LLHR = 472
    INS_LLHRL = 473
    INS_LLIHF = 474
    INS_LLIHH = 475
    INS_LLIHL = 476
    INS_LLILF = 477
    INS_LLILH = 478
    INS_LLILL = 479
    INS_LMG = 480
    INS_LNDBR = 481
    INS_LNEBR = 482
    INS_LNGFR = 483
    INS_LNGR = 484
    INS_LNR = 485
    INS_LNXBR = 486
    INS_LPDBR = 487
    INS_LPEBR = 488
    INS_LPGFR = 489
    INS_LPGR = 490
    INS_LPR = 491
    INS_LPXBR = 492
    INS_LR = 493
    INS_LRL = 494
    INS_LRV = 495
    INS_LRVG = 496
    INS_LRVGR = 497
    INS_LRVR = 498
    INS_LT = 499
    INS_LTDBR = 500
    INS_LTEBR = 501
    INS_LTG = 502
    INS_LTGF = 503
    INS_LTGFR = 504
    INS_LTGR = 505
    INS_LTR = 506
    INS_LTXBR = 507
    INS_LXDB = 508
    INS_LXDBR = 509
    INS_LXEB = 510
    INS_LXEBR = 511
    INS_LXR = 512
    INS_LY = 513
    INS_LZDR = 514
    INS_LZER = 515
    INS_LZXR = 516
    INS_MADB = 517
    INS_MADBR = 518
    INS_MAEB = 519
    INS_MAEBR = 520
    INS_MDB = 521
    INS_MDBR = 522
    INS_MDEB = 523
    INS_MDEBR = 524
    INS_MEEB = 525
    INS_MEEBR = 526
    INS_MGHI = 527
    INS_MH = 528
    INS_MHI = 529
    INS_MHY = 530
    INS_MLG = 531
    INS_MLGR = 532
    INS_MS = 533
    INS_MSDB = 534
    INS_MSDBR = 535
    INS_MSEB = 536
    INS_MSEBR = 537
    INS_MSFI = 538
    INS_MSG = 539
    INS_MSGF = 540
    INS_MSGFI = 541
    INS_MSGFR = 542
    INS_MSGR = 543
    INS_MSR = 544
    INS_MSY = 545
    INS_MVC = 546
    INS_MVGHI = 547
    INS_MVHHI = 548
    INS_MVHI = 549
    INS_MVI = 550
    INS_MVIY = 551
    INS_MVST = 552
    INS_MXBR = 553
    INS_MXDB = 554
    INS_MXDBR = 555
    INS_N = 556
    INS_NC = 557
    INS_NG = 558
    INS_NGR = 559
    INS_NGRK = 560
    INS_NI = 561
    INS_NIHF = 562
    INS_NIHH = 563
    INS_NIHL = 564
    INS_NILF = 565
    INS_NILH = 566
    INS_NILL = 567
    INS_NIY = 568
    INS_NR = 569
    INS_NRK = 570
    INS_NY = 571
    INS_O = 572
    INS_OC = 573
    INS_OG = 574
    INS_OGR = 575
    INS_OGRK = 576
    INS_OI = 577
    INS_OIHF = 578
    INS_OIHH = 579
    INS_OIHL = 580
    INS_OILF = 581
    INS_OILH = 582
    INS_OILL = 583
    INS_OIY = 584
    INS_OR = 585
    INS_ORK = 586
    INS_OY = 587
    INS_PFD = 588
    INS_PFDRL = 589
    INS_RISBG = 590
    INS_RISBHG = 591
    INS_RISBLG = 592
    INS_RLL = 593
    INS_RLLG = 594
    INS_RNSBG = 595
    INS_ROSBG = 596
    INS_RXSBG = 597
    INS_S = 598
    INS_SDB = 599
    INS_SDBR = 600
    INS_SEB = 601
    INS_SEBR = 602
    INS_SG = 603
    INS_SGF = 604
    INS_SGFR = 605
    INS_SGR = 606
    INS_SGRK = 607
    INS_SH = 608
    INS_SHY = 609
    INS_SL = 610
    INS_SLB = 611
    INS_SLBG = 612
    INS_SLBR = 613
    INS_SLFI = 614
    INS_SLG = 615
    INS_SLBGR = 616
    INS_SLGF = 617
    INS_SLGFI = 618
    INS_SLGFR = 619
    INS_SLGR = 620
    INS_SLGRK = 621
    INS_SLL = 622
    INS_SLLG = 623
    INS_SLLK = 624
    INS_SLR = 625
    INS_SLRK = 626
    INS_SLY = 627
    INS_SQDB = 628
    INS_SQDBR = 629
    INS_SQEB = 630
    INS_SQEBR = 631
    INS_SQXBR = 632
    INS_SR = 633
    INS_SRA = 634
    INS_SRAG = 635
    INS_SRAK = 636
    INS_SRK = 637
    INS_SRL = 638
    INS_SRLG = 639
    INS_SRLK = 640
    INS_SRST = 641
    INS_ST = 642
    INS_STC = 643
    INS_STCH = 644
    INS_STCY = 645
    INS_STD = 646
    INS_STDY = 647
    INS_STE = 648
    INS_STEY = 649
    INS_STFH = 650
    INS_STG = 651
    INS_STGRL = 652
    INS_STH = 653
    INS_STHH = 654
    INS_STHRL = 655
    INS_STHY = 656
    INS_STMG = 657
    INS_STRL = 658
    INS_STRV = 659
    INS_STRVG = 660
    INS_STY = 661
    INS_SXBR = 662
    INS_SY = 663
    INS_TM = 664
    INS_TMHH = 665
    INS_TMHL = 666
    INS_TMLH = 667
    INS_TMLL = 668
    INS_TMY = 669
    INS_X = 670
    INS_XC = 671
    INS_XG = 672
    INS_XGR = 673
    INS_XGRK = 674
    INS_XI = 675
    INS_XIHF = 676
    INS_XILF = 677
    INS_XIY = 678
    INS_XR = 679
    INS_XRK = 680
    INS_XY = 681
    INS_ENDING = 682

    GRP_INVALID = 0

    GRP_JUMP = 1

    GRP_DISTINCTOPS = 128
    GRP_FPEXTENSION = 129
    GRP_HIGHWORD = 130
    GRP_INTERLOCKEDACCESS1 = 131
    GRP_LOADSTOREONCOND = 132
    GRP_ENDING = 133

    extend Register
  end
end
