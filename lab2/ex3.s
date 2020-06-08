.data
op1: .byte 150
op2: .byte 100

.text
.globl main
.ent main
main:
	la $t0, op2
	lbu $t0, ($t0)
	la $t1, op1
	lbu $t1, ($t1)
	add $t3, $t0, $t1

	li $v0, 1
	move $a0, $t3
	syscall

	li $v0, 10
	syscall


.end main