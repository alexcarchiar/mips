#operations on matrix data
.data
matrix: .word 154, 123, 109, 86, 4, 0, 412, -23, -231, 9, 50, 0, 123, -24, 12, 55, -45, 0, 0, 0, 0, 0, 0, 0
mess: .asciiz "End\n"


.text
.globl main
.ent main
main:
	#sum row by row
	la $t0, matrix
	addi $t4, $t0, 72
row_loop_ext:
	and $t3, $0, $0 #sum in row
	addi $t1, $t0, 20 #terminator current row
row_loop_int:
	lw $t2, ($t0)
	add $t3, $t3, $t2 #adding element

	addi $t0, $t0, 4
	bne $t0, $t1, row_loop_int #internal loop

	sw $t3, ($t0)

	addi $t0, $t0, 4
	bne $t0, $t4, row_loop_ext #external loop

	#sum column by column
	la $t6, matrix
	addi $t4, $0, 6 #terminator external loop
	and $t5, $0, $0
	li $t7, 4
col_loop_ext: 
	and $t3, $0, $0 #sum in col
	mul $t0, $t5, $t7
	add $t0, $t0, $t6
	addi $t1, $t0, 72  #terminator current col
col_loop_int:
	lw $t2, ($t0)
	add $t3, $t3, $t2

	addi $t0, $t0, 24
	
	bne $t1, $t0, col_loop_int #internal loop

	sw $t3, ($t0)
	addi $t5, $t5, 1 
	bne $t5, $t4, col_loop_ext
end:
	la $a0, mess
	li $v0, 4
	syscall

	li $v0, 10
	syscall
	.end main