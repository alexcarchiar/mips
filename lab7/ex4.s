#ex4 lab 7
.data
vett: .word 3, 4, 5, 7, 1, 2
len: .word 6

.text
.globl main
.ent main

main:
	la $a0, vett
	la $a1, len
	lw $a1, 0($a1)

	jal massimo
	add $a0, $v0, $0
	li $v0, 1
	syscall
	j end

massimo:
	li $t0, 0 #counter
	li $t1, 0 #stores maximum value
loop:
	lw $t2, 0($a0)
	bge $t1, $t2, no_change
	add $t1, $0, $t2
no_change:
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	bne $t0, $a1, loop
	add $v0, $t1, $0
	jr $ra

end:
	li $v0, 10
	syscall
	.end main