#ex4 lab 4
.data
DIM: .word 10 #num values to add
prompt: .asciiz "Insert your numbers: "
avg: .asciiz "\nAverage: "
end: .asciiz "\nEnd\n"

.text
.globl main
.ent main
main:
	li $t0, 0 #t0 contains the sum
	la $t1, DIM
	lw $t1, ($t1)
	li $t2, 1 #counter

	li $v0, 4 #printing prompt
	la $a0, prompt
	syscall

loop:
	li $v0, 5 #reading number
	syscall
	add $t0, $v0, $t0
	addi $t2, $t2, 1
	bne $t2, $t1, loop

	div $t0, $t1

	#printing result
	li $v0, 4 #printing closing message
	la $a0, avg
	syscall

	mflo $a0
	li $v0, 1
	syscall

end_program:
	li $v0, 4 #printing closing message
	la $a0, end
	syscall

.end main
li $v0, 10
syscall