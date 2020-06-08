.data
w1: .word 10
w2: .word 32
w3: .word 5
return: .asciiz "\n"
mess: .asciiz "Increasing order:\n"

.text
.globl main
.ent main
main:
	lw $t0, w1
	lw $t1, w2
	lw $t2, w3

	blt $t0,$t1, NoSwapA_B
	move $t3, $t0
	move $t0, $t1
	move $t1, $t3

NoSwapA_B:
	blt $t0, $t2, NoSwapA_C
	move $t3, $t0
	move $t0, $t2
	move $t2, $t3

NoSwapA_C:
	blt $t1, $t2, NoSwapB_C
	move $t3, $t1
	move $t1, $t2
	move $t2, $t3

NoSwapB_C:
	li $v0, 4
	la $a0, mess
	syscall

	move $a0, $t0
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, return
	syscall

	move $a0, $t1
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, return
	syscall

	move $a0, $t2
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, return
	syscall

end:
	li $v0, 10
	syscall
.end main