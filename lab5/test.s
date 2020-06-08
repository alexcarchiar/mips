.data
d: .word 0xFFFFFFFF

.text
.globl main
.ent main
main:
	lw $t1, d
	lw $t0, d
	bgt $t0, $t1, end
end:
	li $v0, 10
	syscall