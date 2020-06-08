#ex2 lab6
#10 is the value for \n
#we use fp and sp to go through the string from top
#and down. We have a double counter to make sure everything is ok
#the program could be optimized because I go through the string twice
.data
mess: .asciiz "Insert a string\n"
mess2: .asciiz "Finished reading\n"
non_pal: .asciiz "The string is not palindrome\n"
pal: .asciiz "The string is palindrome\n"

.text
.globl main
.ent main
main:
	li $v0, 4
	la $a0, mess
	syscall

	li $t0, 0 #using as a counter
	li $t1, 10
	addi $fp, $sp, -4 #this frame pointer is used to keep track of the beginning of the string
read:
	li $v0, 12
	syscall
	beq $v0, $t1, post
	addi $sp, $sp, -4

	add $t2, $0, $v0
	sw $t2, 0($sp)
	addi $t0, $t0, 1
	j read

post:
	add $t1, $0, $0 #$t1 is the new counter, $t0 sets the end condition	
	li $t4, 4

palindrome:
	lw $t2, 0($sp)
	lw $t3, 0($fp)

	bne $t2, $t3, not_palindrome
	

	addi $sp, $sp, 4
	addi $sp, $sp, -4
	addi $t1, $t1, 1
	blt $fp, $sp, palindrome

	li $v0, 4
	la $a0, pal
	syscall
	j end

not_palindrome:
	li $v0, 4
	la $a0, non_pal
	syscall
	j end

end:
	li $v0, 10
	syscall