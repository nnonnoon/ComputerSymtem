.data # data section

text_1: .asciiz "Result = "
text_2: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

min_three:
    addi $sp, $sp, -8           # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)              # store $ra to stack
    sw $fp, 0($sp)              # store $fp to stack

    addu $fp, $zero, $sp        # set $fp to the current value of $sp (top of stack)

    lw $s0, 8($fp)              # load x = 0xabcd to $s0
    lw $s1, 12($fp)             # load y = 0xdead to $s1
    lw $s2, 16($fp)             # load z = max_three(y^z, x^z, y^x) to $s2

    slt $s3, $s0, $s1           # if (x < y)
    beq $s3, $0, else_1         # if $s3 == 0 go to else_1
    slt $s3, $s2, $s0           # if (z < x)
    beq $s3, $0, else_1_1       # if $s3 == 0 go to else_1_1
    addu $v0, $zero, $s2        # return the value in the f variable (in $t2) by placing it to $v0
    j return                    # jump to return

    else_1_1:
        addu $v0, $zero, $s0    # return the value in the f variable (in $t0) by placing it to $v0
        j return                # jump to return

    else_1:
        slt $s3, $s2, $s1       # if (z < y)
        beq $s3, $0, else_2_1   # if $s3 == 0 go to else_2_1
        addu $v0, $zero, $s2    # return the value in the f variable (in $s2) by placing it to $v0
        j return                # jump to return

        else_2_1:
          addu $v0, $zero, $s1  # return the value in the f variable (in $s1) by placing it to $v0
          j return              # jump to return

    return:
        lw $ra, 4($sp)          # restore $ra
        lw $fp, 0($sp)          # restore $fp

        addi $sp, $sp , 8       # deallocate the stack memory
        jr $ra                  # jump to an instruction at the address specified in $ra whose value


max_three:
    addi $sp, $sp, -8           # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)              # store $ra to stack
    sw $fp, 0($sp)              # store $fp to stack

    addu $fp, $zero, $sp        # set $fp to the current value of $sp (top of stack)

    lw $s0, 8($fp)              # load max = x = y^z  to $s0
    lw $s1, 12($fp)             # load y = x^z to $s1
    lw $s2, 16($fp)             # load z = y^x to $s2

    slt $s3, $s0, $s1           # if ( max < y )
    beq $s3, $0, check_z        # if $s3 == 0 go to check_z
    add $s0, $0, $s1            # max = y

    check_z:
        slt $s3, $s0, $s2       # if ( max < z )
        beq $s3, $0, exit       # if $s3 == 0 go to exit
        add $s0, $0, $s2        # max = z

    exit:
        addu $v0, $zero, $s0    # return the value in the f variable (in $s0) by placing it to $v0

    lw $ra, 4($sp)              # restore $ra
    lw $fp, 0($sp)              # restore $fp

    addi $sp, $sp , 8           # deallocate the stack memory
    jr $ra                      # jump to an instruction at the address specified in $ra whose value


foo:
    li $t2, 0xbeef              # z = $t2 = 0xbeef

    addi $sp, $sp , -8          # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)              # store $ra to stack
    sw $fp, 0($sp)              # store $fp to stack

    addu $fp, $zero, $sp        # set $fp to the current value of $sp (top of stack)


    lw $t0, 8($fp)              # load x = 0xabcd to $t0
    lw $t1, 12($fp)             # load y = 0xdead to $t1

    addi $sp, $sp, -8           # reserve space for the two local variables 0xabcd and 0xdead
    sw $t1, 4($sp)              # store  0xdead to $t1
    sw $t0, 0($sp)              # store  0xabcd to $t0

    addi $sp, $sp , -12         # reserve space for the tree local variables 0xabcd , 0xdead and 0xbeef


    xor $t3, $t1, $t0           # y = 0xdead  xor  x = 0xabcd  to $t3
    sw $t3, 8($sp)              # store $t3 to stack
    xor $t3, $t0, $t2           # x = 0xdead xor z = 0xbeef to $t3
    sw $t3, 4($sp)              # store $t3 to stack
    xor $t3, $t1, $t2           # y = 0xdead xor z = 0xbeef to $t3
    sw $t3, 0($sp)              # store $t3 to stack

    jal max_three               # jump and link to max_three

    addi $sp, $sp, 12           # deallocate the stack memory
    addu $t2, $0, $v0           # z = max_three(y^z, x^z, y^x)


    lw $t0, 0($sp)              # load $t0 from stack
    lw $t1, 4($sp)              # load $t1 from stack
    addi $sp, $sp, 8            # deallocate the stack memory

    addi $sp, $sp, -12          # reserve space for the tree local variables 0xabcd , 0xdead and 0xbeef
    sw $t2, 8($sp)              # store z = max_three(y^z, x^z, y^x) to stack
    sw $t1, 4($sp)              # store 0xdead to stack
    sw $t0, 0($sp)              # store 0xabcd to stack

    jal min_three               # jump and link to min_three

    addi $sp, $sp, 12           # deallocate the stack memory

    lw $ra, 4($sp)              # restore $ra
    lw $fp, 0($sp)              # restore $fp

    addi $sp, $sp , 8           # deallocate the stack memory
    jr $ra                      # jump to an instruction at the address specified in $ra whose value


main:
    li $v0, 4                   # print string
    la $a0, text_1              # print text_1
    syscall                     # call command print

    li $t0, 0xabcd              # $t0 = 0xabcd
    li $t1, 0xdead              # $t1 = 0xdead

    addi $sp, $sp , -8          # reserve space for the two local variables 0xabcd and 0xdead
    sw $t1, 4($sp)              # store 0xdead to stack
    sw $t0, 0($sp)              # store 0xabcd to stack
    jal foo                     # jump and link to foo
    add $t3, $0 ,$v0            # return $v0 from function foo to $t3

    li $v0, 1                   # print int
    add  $a0, $0 , $t3          # print
    syscall                     # call command print

    li $v0, 4                   # print string
    la $a0, text_2              # print text_2
    syscall                     # call command print

    li $v0, 10                  # exit
	syscall                     # call command exit