#ex1 lab9
#computes the price of a parking spot
.data
ora_in: .byte 12, 47
ora_out: .byte 18, 14
X: .byte 1
Y: .byte 40

.text
.globl main
.ent main
main:
	la $a0, ora_in
	la $a1, ora_out
	lbu $a2, X
	lbu $a3, Y
	jal costoParcheggio
	addi $a0, $v0, 0
	li $v0, 1
	syscall
	j end

costoParcheggio:
	#we convert the time into minutes: starting time is hour*60 + starting minute
	#same for ending hour
	#compute difference, divide by Y and multiply by x
	lbu $t0, 0($a0) #starting hour
	li $t1, 60
	mul $t0, $t0, $t1
	lbu $t2, 1($a0) #starting minute
	add $t0, $t0, $t2

	lbu $t2, 0($a1) #ending hour
	mul $t1, $t1, $t2
	lbu $t2, 1($a1) #ending minute
	add $t1, $t1, $t2

	sub $t0, $t1, $t0 #time difference

	div $t0, $a3 #finding the number of periods
	mflo $t0
	mfhi $t1 #remainder

	li $t2, 0
	beq $t1, $t2, no_remainder
	addi $t0, $t0, 1
no_remainder:
	mul $v0, $t0, $a2


	jr $ra
	.end costoParcheggio

end:
	li $v0, 10
	syscall
	.end main