#vector product row * col
.data
row: .word 1, 2, 3, 4
col: .word 5, 6, 7, 8
res: .space 64
mess: .asciiz "End\n"

.text
.globl main
.ent main
main:
	la $t0, row #initializing row
	la $t2, res #initializing res

	addi $t3, $t0, 16 #termination for row
loop_ext:
	lw $t5, ($t0) #loading word at current index
	la $t1, col #initializing col
	addi $t4, $t1, 16 #termination for col
loop_int:
	lw $t6, ($t1)

	addi $t1, $t1, 4 #updating col address
	
	mul $t7, $t6, $t5 #multiplying xi with yj
	sw $t7, ($t2) #storing in res
	addi $t2, $t2, 4 #updating res address	

	bne $t1, $t4, loop_int #repeat internal

	addi $t0, $t0, 4
	bne $t0, $t3, loop_ext #repeat external
end:
	la $a0, mess
	li $v0, 4
	syscall

	li $v0, 10
	syscall
.end main