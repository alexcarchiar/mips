.data
DIM : .word 5
#mat: .word 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 5
#mat: .word 1, 4, 5, 6, 7, 4, 2, 8, 6, 4, 5, 8, 3, 2, 9, 6, 6, 2, 4, 4, 7, 4, 9, 4, 5
#mat: .word 1, 3, 5, 6, 7, 4, 2, 8, 6, 4, 5, 8, 3, 2, 9, 6, 6, 2, 4, 4, 7, 4, 9, 4, 5
mat: .word 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 9, 0, 0, 0, 4, 5

.text
.globl main
.ent main
main:
	la $t0, mat
	la $t1, DIM
	lw $t1, 0($t1)
	li $t2, 0 #counter for outer loop
	add $s3, $0, $t1
	addi $s3, $s3, -1
	sll $s2, $t1, 2
outer_loop:
	addi $t4, $t2, 1
	mul $t4, $t4, $t1 
	add $t4, $t4, $t2 #index second element

	mul $t3, $t2, $t1
	addi $t2, $t2, 1
	add $t3, $t3, $t2 #index first element

	sll $t3, $t3, 2 
	sll $t4, $t4, 2

	add $t3, $t3, $t0 #address first element
	add $t4, $t4, $t0 #address second element

	add $t5, $0, $t2 #counter for inner loop
inner_loop:
	lw $t6, 0($t3)
	lw $t7, 0($t4)
	add $t4, $t4, $s2
	addi $t3, $t3, 4
	bne $t6, $0, not_diag
continue:
	bne $t6, $t7, not_sym
	addi $t5, $t5, 1
	bne $t5, $t1 inner_loop
	bne $t2, $s3, outer_loop
	j end_loop
not_diag:
	li $s0, 1
	j continue

end_loop:
	li $t0, 1
	beq $s0, $t0, sym

diag:
	li $a0, 2
	li $v0, 1
	syscall
	j end

sym:
	li $a0, 1
	li $v0, 1
	syscall
	j end

not_sym:
	li $a0, 0
	li $v0, 1
	syscall

end:
	li $v0, 10
	syscall
	.end main