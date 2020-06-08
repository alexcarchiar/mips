.data
num1: .word 5
num2: .word 12
res: .word 0
.text
.globl main
main:
	la $t0, num1
	lw $t1, ($t0)
	la $t0, num2
	lw $t2, ($t0)
	add $t2, $t2, $t1
	la $t0, res
	sw $t2, res
	li $v0, 10
	syscall