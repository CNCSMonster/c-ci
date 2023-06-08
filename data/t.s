	.file	"tmp.c"
	.option pic
	.text
	.comm	_sysy_start,16,8
	.comm	_sysy_end,16,8
	.comm	_sysy_l1,4096,8
	.comm	_sysy_l2,4096,8
	.comm	_sysy_h,4096,8
	.comm	_sysy_m,4096,8
	.comm	_sysy_s,4096,8
	.comm	_sysy_us,4096,8
	.comm	_sysy_idx,4,4
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,11
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
