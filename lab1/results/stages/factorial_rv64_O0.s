	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"factorial.c"
	.globl	factorial                       # -- Begin function factorial
	.p2align	1
	.type	factorial,@function
factorial:                              # @factorial
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
                                        # kill: def $x11 killed $x10
	sw	a0, -20(s0)
	li	a0, 2
	sw	a0, -24(s0)
	li	a0, 1
	sw	a0, -28(s0)
	j	.LBB0_1
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	lw	a1, -24(s0)
	lw	a0, -20(s0)
	blt	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	mulw	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	addiw	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB0_1
.LBB0_3:
	lw	a0, -28(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	factorial, .Lfunc_end0-factorial
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	li	a0, 0
	sd	a0, -32(s0)                     # 8-byte Folded Spill
	sw	a0, -20(s0)
	call	getint@plt
	ld	a1, -32(s0)                     # 8-byte Folded Reload
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	blt	a0, a1, .LBB1_2
	j	.LBB1_1
.LBB1_1:
	lw	a0, -24(s0)
	li	a1, 13
	blt	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:
	li	a0, 1
	sw	a0, -20(s0)
	j	.LBB1_4
.LBB1_3:
	lw	a0, -24(s0)
	call	factorial
	call	putint@plt
	li	a0, 10
	call	putch@plt
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB1_4
.LBB1_4:
	lw	a0, -20(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
