#ex3 lab 4
#it is techinically possible to have overflow
#but the maximum representable number in 32 bit (2,147,483,647)
#is equivalent to about 1634 years, so we can assume
#no overflow
#since we only use bytes, then we definitely cannot have any overflow
.data
day: .byte 10
hour: .byte 22
min: .byte 55
res: .word 0

.text
.globl main
.ent main
main:
	la $t0, day
	lb $t0, ($t0)
	la $t1, hour
	lb $t1, ($t1)
	la $t2, min
	lb $t2, ($t2)

	li $t3, 24
	mul $t0, $t0, $t3
	add $t0, $t0, $t1
	li $t3, 60
	mul $t0, $t0, $t3
	add $t0, $t0, $t2

	la $t1, res
	sw $t0, ($t1)


.end main
li $v0, 10
syscall