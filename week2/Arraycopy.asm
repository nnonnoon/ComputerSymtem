.data # data section
source: .word 3, 1, 4, 1, 5, 9, 0 # data for addition
dest: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # size of array dest

.text # text section

.globl main # call main by SPIM

main:
    la $8, source           # load address source into $8
    la $9, dest             # load address dest into $9
    addi $10, $0, 0         # k is $10 k = 0

    loop:
    sll $11, $10, 2         # $11 keep k*4
    add $11, $8, $11        # calculate address of source[k]
    lw $12, 0($11)          # load source[k] to $12
    beq $12, $0, exit       # if $12 == 0 go to print2
    sll $13, $10, 2         # $13 keeps k*4
    add $13, $9, $13        # calculate address of dest[k]
    sw $12, 0($13)          # store $13 to $12

    addi $10,$10,1          # k=k+1
    j loop                  # go to loop

    exit:
    li	$v0, 10             # exit
    syscall                 # call command exit
