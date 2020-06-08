.data
mess: .asciiz "Inset number"
me: .asciiz "even"
m: .asciiz "odd"

.text
.globl main
.ent main
main:
	la $a0, mess #printing first message
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	move $t0, $v0
	andi $t1, $t0, 1
	beq $t1, $0, lbl #number odd if this result = 1
	la $a0, m #odd number
	li $v0, 4
	syscall
	j end
lbl: la $a0, me #even number
	li $v0, 4
	syscall
end:
	li $v0, 10
	syscall
.end main