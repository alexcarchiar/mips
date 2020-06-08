#ex4 lab9
#computes hamming distance between numbers
DIM = 5
.data
vet1: .word 56, 12, 98, 129, 58
vet2: .word 1, 0, 245, 129, 12
risultato: .space DIM

.text
.globl main
.ent main
main:
	la $a0, vet1
	la $a1, vet2
	la $a2, risultato
	la $a3, DIM
	jal CalcolaDistanzaH
	la $t0, risultato
	li $v0, 1
	lw $a0, 8($t0)
	syscall
	j end

CalcolaDistanzaH:
	li $t0, 1 #used to analysize the bits
	li $t1, 0 #counter for the external loop
	li $t4, 32 #end condition for inner loop
	
ext_loop:
	beq $t1, $a3, end_ext_loop
	lw $t2, 0($a0)
	lw $t3, 0($a1)
	li $t6, 0 #computes hamming distance between $t2 and $t3
	li $t5, 0 #counter for internal loop
int_loop:
	beq $t4, $t5, end_int_loop
	#extracting bit from $t2
	and $t7, $t2, $t0
	srl $t2, $t2, 1
	#extracting bit from $t3
	and $t8, $t3, $t0
	srl $t3, $t3, 1
	#comparison
	sub $t7, $t7, $t8
	beq $t7, $0, no_add
	addi $t6, $t6, 1
no_add:
	addi $t5, $t5, 1
	j int_loop
end_int_loop:
	sw $t6, 0($a2)
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $a2, $a2, 4
	add $t1, $t1, 1
	j ext_loop

end_ext_loop:
	jr $ra
	.end CalcolaDistanzaH

end:
	li $v0, 10
	syscall
	.end main