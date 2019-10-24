.data # data section

text_1: .asciiz "\n"

.text # text section

.globl main # call main by SPIM


rec_func:
    addi $sp, $sp , -8          # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)              # store $ra to stack
    sw $fp, 0($sp)              # store $fp to stack
    addu $fp, $zero, $sp        # set $fp to the current value of $sp (top of stack)

    lw $s0, 8($fp)              # load n = 5 to $s0


    slt $s1, $0, $s0            # if (n > 0)
    beq $s1, $0, return         # if $s1 == 0 go to return

    li $v0, 1                   # print int
    add $a0, $0, $s0            # print
    syscall                     # call command print

    li $v0, 4                   # print string
    la $a0, text_1              # print text_1
    syscall                     # call command print


    addi $s0, $s0, -2           # $s0 = n - 2
    addi $sp, $sp, -4           # reserve space for the one local variables $s0 = n - 2
    sw $s0, 0($sp)              # store $s0 = n-2 to stack
    jal rec_func                # jump and link to rec_func

    addi $sp, $sp, 4            # deallocate the stack memory

    lw $s0, 8($fp)              # load n = 5 to $s0

    addi $s0, $s0, -3           # $s0 = n - 3
    addi $sp, $sp, -4           # reserve space for the one local variables $s0 = n - 3
    sw $s0, 0($sp)              # store $s0 = n-2 to stack
    jal rec_func                # jump and link to rec_func

    addi $sp, $sp, 4            # deallocate the stack memory


    lw $s0, 8($fp)              # load n = 5 to $s0

    li $v0, 1                   # print int
    add $a0, $0, $s0            # print
    syscall                     # call command print

    li $v0, 4                   # print string
    la $a0, text_1              # print text_1
    syscall                     # call command print


    lw $ra, 4($sp)              # restore $ra
    lw $fp, 0($sp)              # restore $fp

    addi $sp, $sp , 8           # deallocate the stack memory
    jr $ra                      # jump to an instruction at the address specified in $ra whose value



return:
    lw $ra, 4($sp)              # restore $ra
    lw $fp, 0($sp)              # restore $fp

    addi $sp, $sp , 8           # deallocate the stack memory
    jr $ra                      # jump to an instruction at the address specified in $ra whose value



main:
    li $t0 , 5                  # $t0 = 5

    addi $sp, $sp, -4           # reserve space for the one local variables 5
    sw $t0, 0($sp)              # store 5 to stack
    jal rec_func                # jump and link to rec_func

    addi $sp, $sp , 4           # deallocate the stack memory

    li $v0, 10                  # exit
    syscall                     # call command exit

