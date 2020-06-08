.data
var: .word 0x3FFFFFF0

.text
.globl main
.ent main
main:
	lw $t1, var
	li $t0, 2
	mul $t1, $t0, $t1

	li $v0, 1
	move $a0, $t1
	syscall

	addi $t0, $t1, 40
	li $v0, 1
	move $a0, $t0
	syscall

	li $t2, 40
	add $t2, $t2, $t1
	li $v0, 1
	move $a0, $t2
	syscall

	.end main
	li $v0, 10
	syscall
