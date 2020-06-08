#program that converts fahr to c
#and vice versa
#--------------
#data
.data
param: .word 1 #0 is fahr to cel, 1 is cel to fahr
in:   .word 10
out: .word 0

#instructions
.text
.globl main
main:
	la $t0, param
	lw $t0, ($t0) #loading parameter

	beq $t0, 1, else #checking parameter
	la $t0, in
	lw $t0, ($t0) # loading input
	#conversion fahr to cel
	addi $t0, $t0, -32
	addi $t1, $0, 5
	mul $t0, $t0, $t1
	addi $t1, $0, 9
	div $t0, $t1
	mflo $t0
	j exit
else:
	la $t0, in
	lw $t0, ($t0) # loading input
	#conversion cel to fahr
	addi $t1, $0, 9
	mul $t0, $t0, $t1
	addi $t1, $0, 5
	div $t0, $t1
	mflo $t0
	addi $t0, $t0, 32
exit:
	la $t1, out
	sw $t0, ($t1) #writing out the result

	li $v0, 10
	syscall