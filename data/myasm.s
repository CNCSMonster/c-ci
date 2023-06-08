	.file	"/test/data/t.c"
	.option pic
    .text
	.text
	.align	1
	.globl	main
    .type main, @function
main:
    addi sp, sp, -16
	sd ra, 8(sp)
    li gp, 11
    mv a0, gp
	ld ra, 8(sp)
    addi sp, sp, 16
    ret
	.size	main, .-main
    .section	.note.GNU-stack,"",@progbits
