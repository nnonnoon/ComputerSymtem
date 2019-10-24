#This MIPS assembly program translates from the following C snippet

.data # data section

source: .word 3, 1, 4, 1, 5, 9, 0
dest: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text # text section

.globl main # call main by SPIM

main:

la $8 , source
la $9 , dest

addi $10 ,$0 ,0

loop:
sll $11,$10,2
add $11,$8,$11
lw $12,0($11)
beq $12,$0,exit

sll $13,$10,2
add $13,$9,$13
sw $12,0($13)

addi $10 ,$10 ,1
j loop

exit:
li	$v0 ,10
syscall