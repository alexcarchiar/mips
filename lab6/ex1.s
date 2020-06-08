#ex1 lab6
#have to create an algorithm in two steps
#first part: divide by ten to extract the
#digits
#second part: print everything in two parts
#in order to convert from digit to ASCII
#character: remember that 48 is the number for
#character 0, 57 is the one for 9
.data
num : .word 31411592653
mess: .asciiz "Printing the number\n"

.text
.globl main
.ent main
main:
	la $t0, num
	lw $t0, 0($t0) #loaded num

	li $t1, 10
	li $t3, 0
div_loop:
	addi $sp, $sp, -4 #increasing stack size
	div $t0, $t1 #dividing by 10
	mflo $t0
	mfhi $t2
	sw $t2, 0($sp)
	addi $t3, $t3, 1
	bne $t0, 0, div_loop

	
	li $v0, 4
	la $a0, mess
	syscall
print_loop:
	lw $t0, 0($sp)
	addi $t0, $t0, 48

	addi $t3, $t3, -1
	addi $sp, $sp, 4 #freeing stack
	add $a0, $0, $t0
	li $v0, 11
	syscall
	bne $t3, 0, print_loop



end:
	li $v0, 10
	syscall
.end main