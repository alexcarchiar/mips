#ex7 lab9
#John Conway's game of life
#this code prints the first generation and the following one
RIGHE = 9
COLONNE = 9
.data
matrice1: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
matrice2: .space 81
new_line: .asciiz "\n"
.text
.globl main
.ent main
main:
	#printing first matrix
	la $a0, matrice1
	li $a1, RIGHE
	li $a2, COLONNE
	jal stampaMatrice
	#j end

	li $v0, 4
	la $a0, new_line
	syscall

	la $a0, matrice1
	la $a1, matrice2
	li $a2, RIGHE
	li $a3, COLONNE
	jal evoluzione
	j end

evoluzione:
	li $t0, 0
	li $t8, 3
	li $t7, 2
ext_loop_evo:
	beq $t0, $a2, end_ext_loop_evo

	li $t1, 0
int_loop_evo:
	beq $t1, $a3, end_int_loop_evo
	mul $t2, $t0, $a3
	add $t2, $t2, $t1

	#saving variables
	addi $sp, $sp, -40
	sw $a0, 36($sp)
	sw $a1, 32($sp)
	sw $a2, 28($sp)
	sw $a3, 24($sp)
	sw $ra, 20($sp)
	sw $t0, 16($sp)
	sw $t1, 12($sp)
	sw $t2, 8($sp)
	sw $t7, 4($sp)

	li $t7, 12
	lw $t7, 4($sp)

	sw $t8, 0($sp)

	li $t8, 12
	lw $t8, 0($sp)


	#loading parameters
	add $a0, $a0, $0
	add $a1, $0, $t2
	add $a2, $a2, $0
	add $a3, $a3, $0
	jal contaVicini

	#retrieving the variables
	lw $a0, 36($sp)
	lw $a1, 32($sp)
	lw $a2, 28($sp)
	lw $a3, 24($sp)
	lw $ra, 20($sp)
	lw $t0, 16($sp)
	lw $t1, 12($sp)
	lw $t2, 8($sp)
	lw $t7, 4($sp)
	lw $t8, 0($sp)
	addi $sp, $sp, 40

	#need to see if the cell is alive
	add $t3, $t2, $a0
	lb $t4, 0($t3)
	beq $t4, $0, dead

	#here the cell is alive
	blt $v0, $t7, dies
	bgt $v0, $t8, dies

	#here the cells stays alive
	#saving into second matrix
	add $t3, $t2, $a1
	sb $t4, 0($t3)
	j int_loop_increment_evo
dies:
	li $t4, 0 #killing
	#saving into second matrix
	add $t3, $t2, $a1
	sb $t4, 0($t3)
	j int_loop_increment_evo
dead:
	#need to verify the content of $v0
	bne $v0, $t8, stays_dead
	li $t4, 1
	#saving into second matrix
	add $t3, $t2, $a1
	sb $t4, 0($t3)
	j int_loop_increment_evo
stays_dead:
	add $t3, $t2, $a1
	sb $t4, 0($t3)
	j int_loop_increment_evo
int_loop_increment_evo:

	addi $t1, $t1, 1
	j int_loop_evo
end_int_loop_evo:

	addi $t0, $t0, 1
	j ext_loop_evo

end_ext_loop_evo:
	#need to add print
	add $a0, $a1, $0 #matrix address
	add $a1, $a2, $0 #matrix rows
	add $a2, $a1, $0 #matrix columns
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal stampaMatrice
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	.end evoluzione

end:
	li $v0, 10
	syscall
	.end main

#procedure to print
stampaMatrice:
	mul $t0, $a1, $a2 #end condition
	li $t1, 0 #progressive counter
	li $t3, 0 #counter for external loop
loop_ext_stampa:
	beq $t3, $a1, end_print
	li $t4, 0
loop_int_stampa:
	beq $t4, $a2, end_loop_int_stampa
	add $t8, $a0, $0 #saving matrix index
	#need to print the cell
	add $a0, $t1, $t8 #address of current element
	li $v0, 1
	lb $a0, 0($a0)
	syscall

	add $a0, $t8, $0 #retrieving matrix index
	addi $t4, $t4, 1
	addi $t1, $t1, 1 #updating progressive counter
	j loop_int_stampa
end_loop_int_stampa:
	#need to print new line
	add $t8, $a0, $0 #saving matrix index
	li $v0, 4
	la $a0, new_line
	syscall
	add $a0, $t8, $0 #retrieving matrix index
	addi $t3, $t3, 1
	j loop_ext_stampa

end_print:
	jr $ra
	.end stampaMatrice

#this is one procedure
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