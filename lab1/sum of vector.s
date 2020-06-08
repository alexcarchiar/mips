.data
vect: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 #vector
res: .word 0
.text
.globl main
main:
	la $t0, vect #initializing pointer
	and $t1, $0, $0 #initializing index
	and $t2, $0, $0 #initializing result
loop:
	lw $t3, ($t0)
	addi $t0, $t0, 4 #updating pointer
	addi $t1, $t1, 1 #updainting index
	add $t2, $t3, $t2 #updating result
	bne $t1, 10, loop #verifying break condition
	la $t0, res #loading result address
	sw $t2, res #writing address
	li $v0, 10
	syscall