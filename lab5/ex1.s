#store in array the first 20 elements for fibonacci
.data
array: .space 80 #word: 4 bytes. 20 words --> 4*20 = 80
mess: .asciiz "End\n"
new: .asciiz "\n"

.text
.globl main
.ent main
main:
	la $t0, array #loading array
	add $t1, $t0, 76 #terminating point

	#initializing fibonacci
	li $t2, 0
	li $t3, 1
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t3, ($t0)


loop:
	beq $t1, $t0, end
	add $t4, $t3, $t2 #new element

	#update last two elements
	or $t2, $t3, $0
	or $t3, $t4, $0

	addi $t0, $t0, 4 #updating address

	sw $t4, ($t0)

	j loop
	
end:
	la $a0, mess
	li $v0, 4
	syscall


	li $v0, 10
	syscall
.end main