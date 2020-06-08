#ex1 lab8
.data

.text
.globl main
.ent main
main:
	li $t0, 4
	li $t1, 2
	li $t2, -5
	li $t3, 3
	li $s0, 8
	li $s1, 4
	li $s2, 27
	li $s3, 9
	li $s4, 64
	li $s5, 16

	#first parameter OK
	add $a0, $t0, $t1
	add $a0, $a0, $t2
	add $a0, $a0, $t3


	#second parameter OK
	mul $t4, $t0, $s0
	add $a1, $t4, $0
	mul $t4, $t1, $s1
	add $a1, $t4, $a1
	mul $t4, $t2, $t1
	add $a1, $t4, $a1
	add $a1, $a1, $t3

	#third parameter OK
	mul $t4, $t0, $s2
	add $a2, $0, $t4
	mul $t4, $t1, $s3
	add $a2, $a2, $t4
	mul $t4, $t2, $t3
	add $a2, $a2, $t4
	add $a2, $a2, $t3

	#fouth parameter OK
	mul $t4, $t0, $s4
	add $a3, $0, $t4
	mul $t4, $t1, $s5
	add $a3, $a3, $t4
	mul $t4, $s1, $t2
	add $a3, $a3, $t4
	add $a3, $a3, $t3

	#passing last parameter | it is N >= 5
	li $t7, 5
	addi $sp, $sp, -4
	sw $t7, 0($sp)

	#saving $t registers
	addi $sp, $sp, -16
	sw $t0, 12($sp)
	sw $t1, 8($sp)
	sw $t2, 4($sp)
	sw $t3, 0($sp)
	jal polinomio

	#retrieving registers
	lw $t0, 12($sp)
	lw $t1, 8($sp)
	lw $t2, 4($sp)
	lw $t3, 0($sp)
	addi $sp, $sp, 16
	j end

polinomio:
	#getting fifth parameter
	lw $t3, 16($sp)
	addi $t3, $t3, -5

	#storing $s registers
	addi $sp, $sp, -12
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $s2, 0($sp)

	#following the exercise guide
	sub $t0, $a1, $a0
	sub $t1, $a2, $a1
	sub $t2, $a3, $a2
	sub $s0, $t1, $t0
	sub $s1, $t2, $t1
	sub $s2, $s1, $s0
	addi $v0, $a3, 0

loop:
	add $s1, $s1, $s2
	add $t2, $t2, $s1
	add $v0, $v0, $t2
	beq $t3, $0, end_loop
	addi $t3, $t3, -1
	j loop
end_loop:
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $s2, 0($sp)

	addi $sp, $sp, 12

	jr $ra
	.end polinomio

end:
	add $a0, $0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	.end main