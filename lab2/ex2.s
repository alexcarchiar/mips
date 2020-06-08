.data
var1: .byte 'm'
var2: .byte 'i'
var3: .byte 'p'
var4: .byte 's'
var5: .byte 0 #null of the string

.text
.globl main
.ent main
main:
	la $t0, var1
	lb $t0, ($t0)
	la $t1, var2
	lb $t1, ($t1)
	la $t2, var3
	lb $t2, ($t2)
	la $t3, var4
	lb $t3, ($t3)
	la $t4, var5
	lb $t4, ($t4)

	#-32 is the value to switch from lowercase to uppercase
	addi $t0, $t0, -32
	addi $t1, $t1, -32
	addi $t2, $t2, -32
	addi $t3, $t3, -32

	#print
	la $t5, var1
	sb $t0, ($t5)
	sb $t1, 1($t5)
	sb $t2, 2($t5)
	sb $t3, 3($t5)
	sb $t4, 4($t5)
	
	li $v0, 4
	move $a0, $t5
	syscall

	li $v0, 10
	syscall
	.end main