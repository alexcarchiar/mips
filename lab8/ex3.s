#ex3 lab8
.data
new: .asciiz "\n"
.text
.globl main
.ent main
main:
	li $a0, 1000
	jal sequenzaDiCollatz
	j end

sequenzaDiCollatz:
	li $s1 , 1 #counts number of elemenents in sequence
	li $s0, 1 #is the number to be compared to
	addi $sp, $sp, -4
	sw $ra, 0($sp)
loop:
	beq $a0, $s0, end_loop
	jal calcolaSuccessivo
	addi $s1, $s1, 1
	addi $a0, $v0, 0
	j loop

end_loop:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $v0, $s1, 0
	jr $ra
	.end sequenzaDiCollatz

calcolaSuccessivo:
	li $t0, 2
	div $a0, $t0
	mfhi $t0
	li $t1, 1
	beq $t0, $t1, odd
even:
	mflo $a0
	j back_to_main

odd:
	li $t0, 3
	mul $t0, $a0, $t0
	addi $a0, $t0, 1
back_to_main:
	#need to print
	li $v0, 1
	syscall
	addi $t0, $a0, 0
	li $v0, 4
	la $a0, new
	syscall
	addi $v0, $t0, 0
	jr $ra
	.end calcolaSuccessivo

end:
	addi $a0, $v0, 0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	.end main