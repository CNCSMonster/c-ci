	.file	"/test/data/t.c"
	.option pic
    .text
    .data
   .globl a
    .align  2
     .type   a, @object
   .size   a, 4
a:
    .word   0

   .globl e
    .align  2
     .type   e, @object
   .size   e, 4
e:
    .word   0

   .globl b
    .align  2
     .type   b, @object
   .size   b, 4
b:
    .word   0

   .globl d
    .align  2
     .type   d, @object
   .size   d, 4
d:
    .word   0

   .globl c
    .align  2
     .type   c, @object
   .size   c, 4
c:
    .word   0

	.text
	.align	1
	.globl	main
    .type main, @function
main:
    addi sp, sp, -112
	sd ra, 104(sp)
	call getint
    mv s0, a0
    la s1, a
	sw s0, 0(s1)
	call getint
    mv a1, a0
    la a2, b
	sw a1, 0(a2)
	sd a1, 0(sp)
	sd a2, 8(sp)
	call getint
	ld a1, 0(sp)
	ld a2, 8(sp)
    mv a3, a0
    la a4, c
	sw a3, 0(a4)
	sd a3, 0(sp)
	sd a1, 8(sp)
	sd a2, 16(sp)
	sd a4, 24(sp)
	call getint
	ld a3, 0(sp)
	ld a1, 8(sp)
	ld a2, 16(sp)
	ld a4, 24(sp)
    mv a5, a0
    la a6, d
	sw a5, 0(a6)
	sd a5, 0(sp)
	sd a1, 8(sp)
	sd a6, 16(sp)
	sd a4, 24(sp)
	sd a3, 32(sp)
	sd a2, 40(sp)
	call getint
	ld a5, 0(sp)
	ld a1, 8(sp)
	ld a6, 16(sp)
	ld a4, 24(sp)
	ld a3, 32(sp)
	ld a2, 40(sp)
    mv a7, a0
    la s2, e
	sw a7, 0(s2)
	lw a7, 0(s1)
	lw s2, 0(a2)
	lw s3, 0(a4)
    mulw s2, s2, s3
    subw a7, a7, s2
	lw s2, 0(a6)
	lw s3, 0(s1)
	lw s4, 0(a4)
    divw s3, s3, s4
    subw s2, s2, s3
    li s3, 0
    bne    a7, s2, .LBB0_2
	j .LBB0_1
.LBB0_1:
    mv s0, s3
    la s1, a
	lw s1, 0(s1)
    la a1, b
	lw a1, 0(a1)
    mulw s1, s1, a1
    la a1, c
	lw a1, 0(a1)
    divw s1, s1, a1
    la a1, e
	lw a1, 0(a1)
    la a2, d
	lw a2, 0(a2)
    addw a1, a1, a2
    mv a2, s0
    beq    s1, a1, .LBB0_2
	j .LBB0_3
.LBB0_2:
    li a2, 1
	j .LBB0_4
.LBB0_3:
    mv s0, a2
    la s1, a
	lw s1, 0(s1)
    la a1, b
	lw a1, 0(a1)
    addw s1, s1, a1
    la a1, c
	lw a1, 0(a1)
    addw s1, s1, a1
    la a1, d
	lw a1, 0(a1)
    la a2, e
	lw a2, 0(a2)
    addw a1, a1, a2
    mv a2, s0
    beq    s1, a1, .LBB0_2
	j .LBB0_4
.LBB0_4:
    mv a3, a2
    mv a0, a3
	ld ra, 104(sp)
    addi sp, sp, 112
    ret
	.size	main, .-main
    .section	.note.GNU-stack,"",@progbits
