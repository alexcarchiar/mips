.data
n1: .byte 10
n2: .byte 0x10
n3: .byte '1'
res: .space 1

.text
.globl main
.ent main
main:
	la $t0, n1
	lb $t0, ($t0)
	la $t1, n2
	lb $t1, ($t1)
	sub $t0, $t0, $t1
	la $t1, n3
	lb $t1, ($t1)
	add $t0, $t0, $t1

	la $t1, res
	sb $t0, ($t1)
	li $v0 10,
	syscall