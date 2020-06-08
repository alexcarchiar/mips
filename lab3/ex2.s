.data
mess: .asciiz "Insert number: "
return: .asciiz "\n"
err: .asciiz "Errore\n"

.text
.globl main
.ent main
main:
     li $v0, 4 #printing mess
     la $a0, mess
     syscall

     li $v0, 5 #asking first number
     syscall
     move $t0, $v0

     li $v0, 4 #printing return
     la $a0, return
     syscall

     li $v0, 4 #printing mess
     la $a0, mess
     syscall

     li $v0, 5 #asking second number
     syscall
     move $t1, $v0

     li $v0, 4 #printing return
     la $a0, return
     syscall

    li $t2, 256
    bge $t0, $t2, errore #chechink first number in one byte
    bge $t1, $t2, errore #checking second number in one byte
    j ok

errore:
	li $v0, 4 #printing mess
     la $a0, err
     syscall
     j end

ok:
    xor $t2, $t0, $t1
    not $t1, $t1
    and $t3, $t1, $t0
    not $t3, $t3
    or $t4, $t3, $t2

    li $v0, 1
    move $a0, $t4
    syscall

end:
	li $v0, 10
	syscall
.end main