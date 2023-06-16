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
	.globl	a
	.data
	.align	2
	.type	a, @object
	.size	a, 4
a:
	.word	1
	.globl	b
	.bss
	.align	2
	.type	b, @object
	.size	b, 4
b:
	.zero	4
	.globl	c
	.data
	.align	2
	.type	c, @object
	.size	c, 4
c:
	.word	1
	.globl	d
	.align	2
	.type	d, @object
	.size	d, 4
d:
	.word	2
	.globl	e
	.align	2
	.type	e, @object
	.size	e, 4
e:
	.word	4
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	lla	a5,a
	lw	a4,0(a5)
	lla	a5,b
	lw	a5,0(a5)
	mulw	a5,a4,a5
	sext.w	a4,a5
	lla	a5,c
	lw	a5,0(a5)
	divw	a5,a4,a5
	sext.w	a3,a5
	lla	a5,e
	lw	a4,0(a5)
	lla	a5,d
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a4,a3
	bne	a4,a5,.L2
	lla	a5,a
	lw	a4,0(a5)
	lla	a5,b
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a4,a5
	lla	a5,a
	lw	a5,0(a5)
	mulw	a5,a4,a5
	sext.w	a4,a5
	lla	a5,c
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a3,a5
	lla	a5,d
	lw	a4,0(a5)
	lla	a5,e
	lw	a5,0(a5)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a4,a3
	ble	a4,a5,.L3
.L2:
	lla	a5,a
	lw	a4,0(a5)
	lla	a5,b
	lw	a3,0(a5)
	lla	a5,c
	lw	a5,0(a5)
	mulw	a5,a3,a5
	sext.w	a5,a5
	subw	a5,a4,a5
	sext.w	a2,a5
	lla	a5,d
	lw	a4,0(a5)
	lla	a5,a
	lw	a3,0(a5)
	lla	a5,c
	lw	a5,0(a5)
	divw	a5,a3,a5
	sext.w	a5,a5
	subw	a5,a4,a5
	sext.w	a5,a5
	mv	a4,a2
	bne	a4,a5,.L4
.L3:
	li	a5,1
	sw	a5,-20(s0)
.L4:
	lw	a5,-20(s0)
	mv	a0,a5
	call	putint@plt
	lw	a5,-20(s0)
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
