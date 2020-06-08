#ex1 lab 7
.data
#asterisco è dato da 42

.text
.globl main
.ent main
main:
	jal stampaTriangolo
	jal stampaQuadrato
	j end

stampaQuadrato:
	addi $t0, $0, 0 #counter for external loop
	addi $t1, $0, 8 #end condition
loop_ext1:
	addi $t2, $0, 0 #counter for internal loop
loop_int1:
	li $v0, 11 #print character
	li $a0, 42 #print '*'
	syscall

	addi $t2, $t2, 1
	bge $t1, $t2, loop_int1

	li $v0, 11
	li $a0, 13
	syscall
	addi $t0, $t0, 1
	bne $t0, $t1, loop_ext1 #go back to external loop
	jr $ra

stampaTriangolo:
	addi $t0, $0, 0 #counter for external loop
	addi $t1, $0, 8 #end condition
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