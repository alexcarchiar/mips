#making an if-else statement
#data
.data
x: .word -5

#instructions
.text
.globl main

main:
	la $t0, x #loading variable x
	lw $t0, ($t0) 

	ble $t0, $0, else #checking x < 0
	addi $s0, $0, -1
	addi $s1, $0, -3
	j end

else:
	addi $s0, $0, 1

#ending program
end:
	li $v0 10
	syscall