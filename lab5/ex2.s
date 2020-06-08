#example of a switch , insert a number and do arithmetic
.data
opa: .word 2043
opb: .word 5
jumptable: .word sum, diff, prod, fra
mess: .asciiz "End\n"
res : .word 0
err: .asciiz "You inserted a wrong input\n"
prompt: .asciiz "Insert a number for an operation (0,1,2,3) -> (+,-,*,/)\n"

.text
.globl main
.ent main
main:
	#printing prompt
	la $a0, prompt
	li $v0, 4
	syscall

	#loading integers
	lw $t1, opa
	lw $t2, opb


	#reading integer
	li $v0, 5
	syscall
	or $t3, $v0, $0
	
	#checking input for default
	li $t4, 0
	blt $t3, $t4, default
	li $t4, 3
	bgt $t3, $t4 , default
	
	#finding the right case
	sll $t3, $t3, 2
	lw $t0, jumptable($t3)
	jr $t0

sum:
	add $t1, $t1, $t2

	j store
diff:
	sub $t1, $t1, $t2

	j store
prod:
	mul $t1, $t1, $t2

	j store
fra:
	div $t1, $t1, $t2

	j store
default:
	la $a0, err
	li $v0, 4
	syscall
	j end

store:
	or $a0, $0, $t1
	li $v0, 1
	syscall

	la $t0, res
	sw $t1, ($t0)

end:
	la $a0, mess
	li $v0, 4
	syscall

	li $v0, 10
	syscall
.end main