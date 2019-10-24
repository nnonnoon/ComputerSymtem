.data # data section
array_1: .word 100, 200, 300, 400 # define an array of int containing four elements
array_2: .word 10 , 20 , 30 , 40
answer: .word 0 , 0 , 0 , 0
.text # text section

.globl main # call main by SPIM

main:
    la $8 , array_1
    la $9 , array_2
    la $10 , answer

    lw $11 , 0($8)
    lw $12 , 0($9)
    add $13 , $11 , $12
    sw $13 , 0($10)

    lw $11 , 4($8)
    lw $12 , 4($9)
    add $13 , $11 , $12
    sw $13 , 4($10)

    lw $11 , 8($8)
    lw $12 , 8($9)
    add $13 , $11 , $12
    sw $13 , 8($10)

    lw $11 , 12($8)
    lw $12 , 12($9)
    add $13 , $11 , $12
    sw $13 , 12($10)


    # you have two put these two lines in for your code to run properly
    # we will explain about them later
    li	$v0, 10
    syscall
