#ex5 lab9
#replaces % with a string
.data
str_orig: .asciiz "% nella citta' dolente, % nell'eterno dolore, % tra la perduta gente %"
str_sost: .asciiz "per me si va"
str_new: .space 200

.text
.globl main
.ent main
main:
	la $a0, str_orig
	la $a1, str_sost
	la $a2, str_new
	jal sostituisci
	li $v0, 4
	la $a0, str_new
	la $a0, str_new
	li $v0, 4
	syscall
	j end
sostituisci:
	li $t0, 37 #ascii code for %
	lb $t1, 0($a0)
ext_loop:
	beq $t1, $0, end_ext_loop
	beq $t0, $t1, int_loop_begin
	sb $t1, 0($a2)
	j skip_int_loop
int_loop_begin:
	add $t2, $0, $a1
int_loop:
	lb $t3, 0($t2)
	beq $t3, $0, end_int_loop
	sb $t3, 0($a2)
	addi $a2, $a2, 1
	addi $t2, $t2, 1
	j int_loop
skip_int_loop:
	addi $a2, $a2, 1
end_int_loop:
	addi $a0, $a0, 1
	
	lb $t1, 0($a0)
	j ext_loop
end_ext_loop:
	jr $ra
	.end sostituisci
end: 
	li $v0, 10
	syscall
	.end main