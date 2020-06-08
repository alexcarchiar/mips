#ex5 lab8
.data
new: .asciiz "\n"
.text
.globl main
.ent main
main:
	li $a0, 1
	li $a1, 2
	li $a2, 3
	li $a3, 4
	addi $sp, $sp, -20
	li $t0, 5
	sw $t0, 16($sp)
	li $t0, 6
	sw $t0, 12($sp)
	li $t0, 7
	sw $t0, 8($sp)
	li $t0, 8
	sw $t0, 4($sp)
	li $t0, 9
	sw $t0, 0($sp)
	jal determinante3x3
	addi $sp, $sp, 20
	addi $a0, $v0, 0
	li $v0, 1
	syscall
	j end

determinante3x3:
	#storing the inputs and the $ra in the stack
	addi $sp, $sp, -20
	sw $a0, 16($sp)
	sw $a1, 12($sp)
	sw $a2, 8($sp)
	sw $a3, 4($sp)
	sw $ra, 0($sp)

	#computing first determinant
	lw $a0, 36($sp)
	lw $a1, 32($sp)
	lw $a2, 24($sp)
	lw $a3, 20($sp)
	jal determinante2x2
	lw $t0, 16($sp)
	mul $s0, $t0, $v0

	#computing second determinant
	lw $a0, 4($sp)
	lw $a1, 32($sp)
	lw $a2, 28($sp)
	lw $a3, 20($sp)
	jal determinante2x2
	lw $t1, 12($sp)
	mul $s1, $t1, $v0

	#computing third determinant
	lw $a0, 4($sp)
	lw $a1, 36($sp)
	lw $a2, 28($sp)
	lw $a3, 24($sp)
	jal determinante2x2
	lw $t2, 8($sp)
	mul $s2, $t2, $v0

	#computing the total determinant
	sub $s0, $s0, $s1
	add $v0, $s0, $s2

	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra
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