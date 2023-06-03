	.file	"b.c"
	.text
	.globl	_Z4add1i
	.type	_Z4add1i, @function
_Z4add1i:
.LFB30:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	movq	stdin(%rip), %rdi
	call	fgetc@PLT
	leal	-48(%rbx,%rax), %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE30:
	.size	_Z4add1i, .-_Z4add1i
	.globl	main
	.type	main, @function
main:
.LFB31:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$3, %edi
	call	_Z4add1i
	movslq	%eax, %rdx
	addl	$1, %eax
	testq	%rdx, %rdx
	js	.L4
.L5:
	subq	$1, %rdx
	cmpq	$-1, %rdx
	jne	.L5
.L4:
	sall	$2, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE31:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 12.2.0-3ubuntu1) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
