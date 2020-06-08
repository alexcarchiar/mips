.data

.text
.globl main
.ent main
main:
	

	addi $a0, $0, 12
	addi $a1, $0, 2
	jal combina
	add $a0, $0, $v0
	li $v0, 1
	syscall
	j end

	

combina:
	sub $t0, $a0, $a1 #termination condition for numerator
	li $t1, 1
	add $t2, $a0, $0
compute_numerator:
	mul $t1, $t1, $t2
	addi $t2, $t2, -1
	bne $t2, $t0, compute_numerator
	
	li $t0, 1 # termination conditon for denominator
	add $t2, $0, $a1
	addi $t3, $0, 1
compute_denominator:
	mul $t3, $t3, $t2
	addi $t2, $t2, -1
	bne $t0, $t2, compute_denominator
	
	div $t1, $t3
	mflo $v0

	jr $ra

end:
	li $v0, 10
	syscall
	.end main