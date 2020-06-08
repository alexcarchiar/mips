#Translating some code
#data
.data
x: .word 15
y: .word 3
z: .space 4

.text
.globl main

main:
	la $t0, x #loading variable x
	lw $t0, ($t0) 
	la $t1, y #loading variable y
	lw $t1, ($t1) 
	div $t0, $t1 #division
	mflo $s0 #storing quotient in s0
	la $t0, z
	sw $s0, ($t0)

	#ending program
	li $v0, 10
	syscall