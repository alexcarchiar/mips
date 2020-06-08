#ex2 lab8
.data

.text
.globl main
.ent main
main:
	li $a0, 5
	jal calcolaSuccessivo
	j end

calcolaSuccessivo:
	li $t0, 2
	div $a0, $t0
	mfhi $t0
	li $t1, 1
	beq $t0, $t1, odd
even:
	mflo $a0
	j back_to_main

odd:
	li $t0, 3
	mul $t0, $a0, $t0
	addi $a0, $t0, 1
back_to_main:
	#need to print
	li $v0, 1
	syscall
	addi $v0, $a0, 0
	jr $ra
	.end calcolaSuccessivo

end:
	li $v0, 10
	syscall
	.end main