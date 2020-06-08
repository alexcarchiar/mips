#ex6 lab9
#sums the values of
#nearby cells into a matrix
RIGHE = 4
COLONNE = 5
.data
matrice: .byte 0, 1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23, 9, 34, 8, 25, 43, 62

.text
.globl main
.ent main
main:
	la $a0, matrice
	li $a1, 4
	li $a2, RIGHE
	li $a3, COLONNE
	jal contaVicini
	add $a0, $v0, $0
	j end

contaVicini:
	#find the "coordinates" of the progressive number
	li $v0, 0
	li $t0, 0
	li $t1, 0 #counts the row
row_loop:
	bgt $t0, $a1, end_row
	addi $t1, $t1, 1
	add $t0, $t0, $a3
	j row_loop
end_row:
	addi $t1, $t1, -1
	#li $t2, 0 #counts column
	li $t2, 0
	mul $t0, $t1, $a3 #finds the row
col_loop:
	beq $t0, $a1, end_col
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	j col_loop
end_col:
	#my coordinates are in $t1, $t2; i do not need the other registers
	#exept for $a registers

	addi $t7, $t1, 0
	addi $t8, $t2, 0

	#summing upper row
	addi $t1, $t1, -1
	ble $t1, $0, no_upper_row
	addi $t2, $t2, -1
	blt $t2, $0, no_left_col_1
	mul $t3, $t1, $a3
	add $t3, $t3, $t2
	add $t3, $t3, $a0
	lb $t4, 0($t3)
	add $v0, $v0, $t4
no_left_col_1:
	addi $t2, $t2, 1
	mul $t3, $t1, $a3
	add $t3, $t3, $t2
	add $t3, $t3, $a0
	lb $t4, 0($t3)
	add $v0, $v0, $t4

	#need to check right col
	addi $t2, $t2, 1
	beq $t2, $a3, no_right_col_1
	mul $t3, $t1, $a3
	add $t3, $t3, $t2
	add $t3, $t3, $a0
	lb $t4, 0($t3)
	add $v0, $v0, $t4
no_right_col_1:
	nop
no_upper_row:
	#resetting coordinates
	add $t1, $t7, $0
	add $t2, $t8, $0

	#summing left and right on same row
	addi $t2, $t2, -1
	blt $t2, $0, no_left_col_2
	mul $t3, $t1, $a3
	add $t3, $t3, $t2
	add $t3, $t3, $a0
	lb $t4, 0($t3)
	add $v0, $v0, $t4

no_left_col_2:
	addi $t2, $t2, 2
	beq $t2, $a3, no_right_col_2
	mul $t3, $t1, $a3
	add $t3, $t3, $t2
	add $t3, $t3, $a0
	lb $t4, 0($t3)
	add $v0, $v0, $t4

no_right_col_2:
	#resetting coordinates
	add $t1, $t7, $0
	add $t2, $t8, $0

	#summing lower row
	addi $t1, $t1, 1
	bge $t1, $a2, no_lower_row
	addi $t2, $t2, -1
	blt $t2, $0, no_left_col_3
	mul $t3, $t1, $a3
	add $t3, $t3, $t2
	add $t3, $t3, $a0
	lb $t4, 0($t3)
	add $v0, $v0, $t4
no_left_col_3:
	addi $t2, $t2, 1
	mul $t3, $t1, $a3
	add $t3, $t3, $t2
	add $t3, $t3, $a0
	lb $t4, 0($t3)
	add $v0, $v0, $t4

	#need to check right col
	addi $t2, $t2, 1
	beq $t2, $a3, no_right_col_3
	mul $t3, $t1, $a3
	add $t3, $t3, $t2
	add $t3, $t3, $a0
	lb $t4, 0($t3)
	add $v0, $v0, $t4
no_right_col_3:
	nop
no_lower_row:
	jr $ra
	.end contaVicini
end:
	li $v0, 10
	syscall
	.end main