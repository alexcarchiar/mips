#ex3 lab9
#computes discount for certain products
NUM = 5
DIM = NUM * 4
SCONTO = 30
ARROTONDA = 1
.data
prezzi: .word 39, 1880, 2394, 1000, 1590
scontati: .space DIM
#scontati: .word 0, 0, 0, 0, 0
.text
.globl main
.ent main
main:
	la $a0, prezzi
	la $a1, scontati
	li $a2, NUM
	li $a3, SCONTO
	li $t0, ARROTONDA
	add $sp, -4
	sw $t0, ($sp)
	jal calcola_sconto
	add $a0, $v0, $0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	j end

calcola_sconto:
	lw $t3, 0($sp) #contains ARROTONDA
	li $t0, 0 #counter
	li $t1, 100 #used to compute discount
	li $v0, 0 #store value for the total discount
	li $t5, 5 #to check remainder
loop:
	beq $t0, $a2, end_loop
	lw $t2, 0($a0) #get the price for the item
	mul $t4, $t2, $a3
	div $t4, $t1
	mfhi $t4
	mflo $t6
	#checking arrotonda is one and the remainder is not 0
	beq $t3, $0, no_add
	blt $t4, $t5, no_add
	addi $t6, $t6, 1
no_add:
	add $v0, $v0, $t6
	sw $t6, 0($a1)

	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t0, $t0, 1

	j loop
end_loop:
	jr $ra
	.end calcola_sconto

end:
	li $v0, 10
	syscall
	.end main