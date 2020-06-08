.data


.text
.globl main
.ent main
main:
	li $v0, 5
	syscall
	move $t1, $v0

	li $v0, 5
	syscall
	move $t2, $v0

	#swap
	sub $t1, $t1, $t2
	add $t2, $t1, $t2
	sub $t1, $t2, $t1


	.end main
	li $v0, 10
	syscall