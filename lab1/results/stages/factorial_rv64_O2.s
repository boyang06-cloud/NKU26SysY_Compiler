	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"factorial.c"
	.globl	factorial                       # -- Begin function factorial
	.p2align	1
	.type	factorial,@function
factorial:                              # @factorial
# %bb.0:
	li	a2, 2
	li	a1, 1
	blt	a0, a2, .LBB0_3
# %bb.1:
	li	a1, 1
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	mv	a3, a2
	mulw	a1, a1, a2
	addiw	a2, a2, 1
	blt	a3, a0, .LBB0_2
.LBB0_3:
	mv	a0, a1
	ret
.Lfunc_end0:
	.size	factorial, .Lfunc_end0-factorial
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	call	getint@plt
	li	a2, 12
	li	a1, 1
	bltu	a2, a0, .LBB1_5
# %bb.1:
	li	a2, 2
	li	a1, 1
	bltu	a0, a2, .LBB1_4
# %bb.2:
	li	a1, 1
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	mv	a3, a2
	mulw	a1, a2, a1
	addiw	a2, a2, 1
	blt	a3, a0, .LBB1_3
.LBB1_4:
	mv	a0, a1
	call	putint@plt
	li	a0, 10
	call	putch@plt
	li	a1, 0
.LBB1_5:
	mv	a0, a1
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
