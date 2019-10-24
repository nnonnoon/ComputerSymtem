.data # data section
array_1: .word 24, 13, 9, -16 # define an array of int containing four elements
array_2: .word 8, 7, -11, 3
.text # text section

.globl main # call main by SPIM

main:
    la $8 , array_1
    la $9 , array_2

    lw $10 , 0($8)
    lw $11 , 0($9)
    mult $10 , $11
    mflo $2

    lw $10 , 4($8)
    lw $11 , 4($9)
    mult $10 , $11
    mflo $12
    add $2 ,$2 ,$12

    lw $10 , 8($8)
    lw $11 , 8($9)
    mult $10 , $11
    mflo $12
    add $2 ,$2 ,$12

    lw $10 , 12($8)
    lw $11 , 12($9)
    mult $10 , $11
    mflo $12
    add $2 ,$2 ,$12


# you have two put these two lines in for your code to run properly
# we will explain about them later
    li	$v0, 10
    syscall
