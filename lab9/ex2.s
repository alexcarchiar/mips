#ex2 lab9
#finds if a year is leap
.data
anni: .word 1945, 2008, 1800, 2006, 1748, 1600
risultato: .byte 0, 0, 0, 0, 0, 0
lunghezza: .word 6
.text
.globl main
.ent main
main:
	la $a0, anni
	la $a1, risultato
	la $a2, lunghezza
	jal bisestile

	la $t0, risultato
	lw $t1, lunghezza
	li $t2, 0
	li $v0, 1
print:
	lb $a0, 0($t0)
	syscall
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	bne $t2, $t1, print

	j end

bisestile:
	li $t0, 100
	li $t1, 400
	li $t2, 4
	li $t3, 0 #counter
	lw $t4, 0($a2) #end condition
	li $t7, 1 #used to store in case true
loop:
	lw $t5, 0($a0) #getting year
	div $t5, $t0
	mfhi $t6
	bne $t6, $0, not_by_100
	div $t5, $t1
	mfhi $t6
	bne $t6, $0, not_by_400
	sb $t7, 0($a1) #setting true value
not_by_400:
	j end_if
not_by_100: 
	div $t5, $t2
	mfhi $t6
	bne $t6, $0, not_by_4
	sb $t7, 0($a1) #setting true value
not_by_4:
	#nothing to do
end_if:
	addi $a1, $a1, 1
	addi $a0, $a0, 4
	addi $t3, $t3, 1
	bne $t4, $t3, loop

	jr $ra
	.end bisestile

end:
	li $v0, 10
	syscall
	.end main