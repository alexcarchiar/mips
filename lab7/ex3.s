.data
string: .asciiz "HELLO"
new: .asciiz "\n"
.text
.globl main
.ent main
main:
	la $s0, string
	li $v0, 4
	la $a0, string
	syscall

loop:
	lb $a0, 0($s0)
	beq $a0, $0, end_loop

	jal to_lower
	sb $v0, 0($s0)

	addi $s0, $s0, 1
	j loop

end_loop:
	la $a0, new
	li $v0, 4
	syscall

	la $s0, string
	li $v0, 4
	la $a0, string
	syscall
	j end

to_lower:
	addi $v0, $a0, 32
	jr $ra

end:
	li $v0, 10
	syscall
	.end main