#ex4 lab8
.data

.text
.globl main
.ent main
main:
	li $a0, 5
	li $a1, 12
	li $a2, 1111
	li $a3, 3
	jal determinante2x2
	j end

determinante2x2:
	mul $t0, $a0, $a3
	mul $t1, $a1, $a2
	sub $t0, $t0, $t1
	addi $v0, $t0, 0
	jr $ra
	.end determinante2x2

end:
	li $v0, 10
	syscall
	.end main