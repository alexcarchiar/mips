#ex2 lab 7
.data
#asterisco è dato da 42
mess: .asciiz "insert integer:\n"

.text
.globl main
.ent main
main:
	li $v0, 4
	la $a0, mess
	syscall

	li $v0,5
	syscall

	add $s0, $0, $v0

	add $a0, $s0, $0
	jal stampaTriangolo

	add $a0, $s0, $0
	jal stampaQuadrato
	j end

stampaQuadrato:
	addi $t0, $0, 0 #counter for external loop
	add $t1, $0, $a0 #end condition
loop_ext1:
	addi $t2, $0, 0 #counter for internal loop
loop_int1:
	li $v0, 11 #print character
	li $a0, 42 #print '*'
	syscall

	addi $t2, $t2, 1
	bne $t1, $t2, loop_int1

	li $v0, 11
	li $a0, 13
	syscall
	addi $t0, $t0, 1
	bne $t0, $t1, loop_ext1 #go back to external loop
	jr $ra
stampaTriangolo:
	addi $t0, $0, 0 #counter for external loop
	add $t1, $0, $a0 #end condition
loop_ext:
	addi $t2, $0, 0 #counter for internal loop
loop_int:
	li $v0, 11 #print character
	li $a0, 42 #print '*'
	syscall

	addi $t2, $t2, 1
	bge $t0, $t2, loop_int

	li $v0, 11
	li $a0, 13
	syscall
	addi $t0, $t0, 1
	bne $t0, $t1, loop_ext #go back to external loop
	jr $ra

end:
	li $v0, 10
	syscall
	.end main