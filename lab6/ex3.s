#ex3 lab6
.data
promptA: .asciiz "Insert a\n"
promptB: .asciiz "Insert b\n"
promptC: .asciiz "Insert c\n"
line: .asciiz "\n"
two: .asciiz "Two solutions\n"
one: .asciiz "One solution\n"
zero: .asciiz "No solutions\n"

.text
.globl main
.ent main
main:
	#reading the first number
	li $v0, 4
	la $a0, promptA
	syscall

	li $v0, 5
	syscall
	add $t0, $v0, $0 #storing it

	li $v0, 4
	la $a0, line
	syscall

	#reading the second one
	li $v0, 4
	la $a0, promptB
	syscall

	li $v0, 5
	syscall
	add $t1, $v0, $0 #storing it

	li $v0, 4
	la $a0, line
	syscall

	#reading the third one
	li $v0, 4
	la $a0, promptC
	syscall

	li $v0, 5
	syscall
	add $t2, $v0, $0 #storing it

	li $v0, 4
	la $a0, line
	syscall

	#we have to compute b^2 - 4ac
	mul $t1, $t1, $t1 #b^2

	mul $t0, $t0, $t2 #ac
	sll $t0, $t0, 2 #multiplying by 4
	sub $t0, $t1, $t0 #b^2 - 4ac

	beq $t0, $0, one_sol
	blt $t0, $0, no_sol

	li $v0, 4
	la $a0, two
	syscall
	j end

one_sol:
	li $v0, 4
	la $a0, one
	syscall
	j end
no_sol:
	li $v0, 4
	la $a0, zero
	syscall
	j end


end:
	li $v0, 10
	syscall
	.end main