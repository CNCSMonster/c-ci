	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.file	"b.c"
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	sd	s0, 144(sp)                     # 8-byte Folded Spill
	addi	s0, sp, 160
	li	a1, 0
	sw	a1, -20(s0)
	li	a0, 33
	sw	a0, -24(s0)
	addi	a0, s0, -160
	li	a2, 136
	call	memset@plt
	li	a0, 1
	sw	a0, -160(s0)
	lw	a0, -160(s0)
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	ld	s0, 144(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 160
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.ident	"Ubuntu clang version 15.0.6"
	.section	".note.GNU-stack","",@progbits
	.addrsig
