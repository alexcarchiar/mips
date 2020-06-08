#ex 1 lab 4
.data
prompt: .asciiz "Inserisci un numero: "
end: .asciiz "\n You inserted: "
over: .asciiz "Your number causes overflow"

.text
.globl main
.ent main
main:
	li $v0, 4 #printing prompt
	la $a0, prompt
	syscall

	li $t0, 10 #we are using decimal base
	li $t1, 45  #flag for minus sign
	li $t2, 0 #input number
	li $t3, 47 #smaller than 0
	li $t4, 58 #higher than 0
	li $t5, 10 #value of \n
	li $t7, 0 #flag for minus

input: 
	li $v0, 12 #reading one character
	syscall

	#checking negative
	bne $t7, $0, continue
	bne $v0, $t1, continue
	li $t1, 1 #t5 = 1 means negative number
	addi $t7, 1

continue:
	addi $t7, $t7, 1
	beq $v0, $t5, end_input #comparing with \n
#a character in ascii has values between 48 and 57 included
	ble $v0,$t3, input
	bge $v0,$t4, input
	
	#conversion into digit
	sub $v0, $v0, $t3
	addi $v0, $v0, -1

	mult $t2, $t0 #increasing previous value
	mfhi $t6
	bne $t6, $0, overflow #checking overflow
	mflo $t2
	add $t2, $t2, $v0 #adding the last digit
	blt $t2,$v0, overflow #checking overflow

	j input

end_input:

	#need to multiply our value by -1 in case t5 = 1
	li $t6, 1
	bne $t1, $t6, positive
	#changing sign
	or $t6, $0, $t2
	sub $t2, $0, $t2

	#checking overflow
	add $t7, $t6, $t2
	bne $t7, $0, overflow


positive:
	li $v0, 4 #printing end
	la $a0, end
	syscall

	li $v0, 1 #printing the inserted number
	or $a0, $t2, $0 
	syscall
	j end_program

overflow:
	li $v0, 4
	la $a0, over
	syscall

end_program:
.end main
li $v0, 10
syscall