.data
d: .half 11
mess: .asciiz "Number of 1-bit: "

.text
.globl main
.ent main
main:
	li $s0, 16 #num of bytes in halfword

	la $t0, d
	lh $t0, 0($t0) #loaded halfword

	and $t1, $0, $0 #counter for loop
	and $t2, $0, $0 #counter for 1-bit
	li $t4, 1 #for logical shift

	loop: beq $t1,$s0, endLoop
		andi $t3, $t0, 1

		bne $t3, 1, else
			addi $t2, $t2, 1
		else:
		srl $t0, $t0, $t4
		addi $t1, $t1, 1

		j loop

	endLoop:

	li $v0, 4 #printing mess
	la $a0, mess
	syscall

	li $v0, 1 #printing number of 1-bit
	move $a0, $t2
	syscall

end:
	li $v0, 10
	syscall
	.end main