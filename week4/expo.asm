.data # data section

text_1: .asciiz "Expo1 result: "
text_2: .asciiz "\n"
text_3: .asciiz "Expo2 result: "
text_4: .asciiz "Expo3 result: "

.text # text section

.globl main # call main by SPIM


expo1:
    addi $sp, $sp, -8               # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)                  # store $ra to stack
    sw $fp, 0($sp)                  # store $fp to stack
    addu $fp, $zero, $sp            # set $fp to the current value of $sp (top of stack)

    lw $s0, 8($fp)                  # load 4 to $s0 = x
    lw $s1, 12($fp)                 # load 7 to $s1 = n

    li $s3, 0                       # $s3 = i = 0
    li $s4, 1                       # $s4 = result = 1

    loop_1:
        slt $s5, $s3, $s1           # if (i<n)
        beq $s5, $0, exit1          # if $s5 == 0 go to exit1
        mult $s4, $s0               # $s1 * $s0 = Hi and Lo registers
        mflo $s4                    # copy Lo to $s4
        addi $s3, $s3, 1            # $s3 = $s3 + 1
        j loop_1                    # jump to loop_1

    exit1:
        add $v0, $0, $s4            # return result
        lw $ra, 4($sp)              # restore $ra
        lw $fp, 0($sp)              # restore $fp

        addi $sp, $sp , 8           # deallocate the stack memory
        jr $ra                      # jump to an instruction at the address specified in $ra whose value



expo2:
    addi $sp, $sp, -8               # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)                  # store $ra to stack
    sw $fp, 0($sp)                  # store $fp to stack
    addu $fp, $zero, $sp            # set $fp to the current value of $sp (top of stack)

    lw $s0, 8($fp)                  # load 4 to $s0 = x
    lw $s1, 12($fp)                 # load 7 to $s1 = n


    beq $s1, $0, exit2              # if  $s1 == 0 go to exit2

    addi $sp, $sp, -4               # reserve space for the two local variables 4
    sw $s0, 0($sp)                  # store $s0 = x to stack

    addi $s1, $s1, -1               # $s1 = $s1 - 1
    addi $sp, $sp, -8               # reserve space for the two local variables 4 and 7
    sw $s1, 4($sp)                  # store $s1 = 7 to stack
    sw $s0, 0($sp)                  # store $s0 = 4 to stack
    jal expo2                       # jump and link to expo2
    addi $sp, $sp , 8               # deallocate the stack memory

    lw $s0, 0($sp)                  # load $s0 from stack
    addi $sp, $sp, 4                # deallocate the stack memory


    mult $s2, $s0                   # $s2 * $s0 = Hi and Lo registers
    mflo $s2                        # copy Lo to $s2

    add $v0, $0, $s2                # return $v0 = $s2


    lw $ra, 4($sp)                  # restore $ra
    lw $fp, 0($sp)                  # restore $fp

    addi $sp, $sp , 8               # deallocate the stack memory
    jr $ra                          # jump to an instruction at the address specified in $ra whose value

exit2:
    addi $s2, $0, 1                 # return $s2 = 1
    lw $ra, 4($sp)                  # restore $ra
    lw $fp, 0($sp)                  # restore $fp

    addi $sp, $sp , 8               # deallocate the stack memory
    jr $ra                          # jump to an instruction at the address specified in $ra whose value



expo3:
    addi $sp, $sp, -8               # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)                  # store $ra to stack
    sw $fp, 0($sp)                  # store $fp to stack
    addu $fp, $zero, $sp            # set $fp to the current value of $sp (top of stack)

    lw $s0, 8($fp)                  # load 4 to $s0 = x
    lw $s1, 12($fp)                 # load 7 to $s1 = n

    beq $s1, $0, exit3              # if  $s1 == 0 go to exit3

    sra $s1, $s1, 1                 # shift right arithmetic (sra) is 2 of n / 2
    addi $sp, $sp, -8               # reserve space for the two local variables 4 and 7
    sw $s1, 4($sp)                  # store $s1 = n to stack
    sw $s0, 0($sp)                  # store $s0 = x to stack
    jal expo3                       # jump and link to expo3
    addi $sp, $sp , 8               # deallocate the stack memory

    addi $sp, $sp, -4               # reserve space for the one local variables $v0
    sw $v0, 0($sp)                  # store $v0 to stack

    lw $s0, 8($fp)                  # load 4 to $s0 = x
    lw $s1, 12($fp)                 # load 7 to $s1 = n


    sra $s1, $s1, 1                 # shift right arithmetic (sra) is 2 of n / 2
    addi $sp, $sp, -8               # reserve space for the two local variables 4 and 7
    sw $s1, 4($sp)                  # store $s1 = n to stack
    sw $s0, 0($sp)                  # store $s0 = x to stack
    jal expo3                       # jump and link to expo3
    addi $sp, $sp , 8               # deallocate the stack memory

    add $s5, $0, $v0                # return $v0 to $s5 = sh

    lw $s3, 0($sp)                  # load $v0 from stack
    addi $sp, $sp, 4                # deallocate the stack memory

    lw $s0, 8($fp)                  # load 4 to $s0 = x
    lw $s1, 12($fp)                 # load 7 to $s1 = n


    li $s6, 1                       # $s6 = 1
    and $s4, $s1, $s6               # $s5 = $s1 and  $s6 ( n % 2 )
    beq $s4, $0 , end               # if $s5 == 0 go to  else
        mult $s0, $s5               # x * fh
        mflo $v0                    # copy Lo to $v0
        mult $v0, $s3               # $v0 * sh
        mflo $v0                    # copy Lo to $v0
        j end                       # jump to end

    else:
        mult $s3, $s5               # fh * sh
        mflo $v0                    # copy Lo to $v0


end:
    lw $ra, 4($sp)                  # restore $ra
    lw $fp, 0($sp)                  # restore $fp

    addi $sp, $sp , 8               # deallocate the stack memory
    jr $ra                          # jump to an instruction at the address specified in $ra whose value


exit3:
    addi $v0, $0, 1                 # return $v0 = 1
    lw $ra, 4($sp)                  # restore $ra
    lw $fp, 0($sp)                  # restore $fp

    addi $sp, $sp , 8               # deallocate the stack memory
    jr $ra                          # jump to an instruction at the address specified in $ra whose value



main:
    li $t0, 4                       # define $t0 = 4
    li $t1, 7                       # define $t1 = 7
    addi $sp, $sp, -8               # reserve space for the two local variables 4 and 7
    sw $t1, 4($sp)                  # store 7 to stack
    sw $t0, 0($sp)                  # store 4 to stack
    jal expo1                       # jump and link to expo1

    add $t2, $0, $v0                # $t2 = $v0

    addi $sp, $sp, 8                # deallocate the stack memory

    li $v0, 4                       # print string
    la $a0, text_1                  # print text_1
    syscall                         # call command print


    li $v0, 1                       # print int
    add $a0, $0, $t2                # print result
    syscall                         # call command print

    li $v0, 4                       # print string
    la $a0, text_2                  # print text_2
    syscall                         # call command print

    ####################################################

    addi $sp, $sp, -8               # reserve space for the two local variables 4 and 7
    sw $t1, 4($sp)                  # store 7 to stack
    sw $t0, 0($sp)                  # store 4 to stack
    jal expo2                       # jump and link to expo2

    add $t3, $0, $v0                # $t2 = $v0

    addi $sp, $sp, 8                # deallocate the stack memory

    li $v0, 4                       # print string
    la $a0, text_3                  # print text_3
    syscall                         # call command print


    li $v0, 1                       # print int
    add $a0, $0, $t3                # print result
    syscall                         # call command print

    li $v0, 4                       # print string
    la $a0, text_2                  # print text_2
    syscall                         # call command print

    ####################################################

    addi $sp, $sp, -8               # reserve space for the two local variables 4 and 7
    sw $t1, 4($sp)                  # store 7 to stack
    sw $t0, 0($sp)                  # store 4 to stack
    jal expo3                       # jump and link to expo3

    add $t4, $0, $v0                # $t2 = $v0

    addi $sp, $sp, 8                # deallocate the stack memory

    li $v0, 4                       # print string
    la $a0, text_4                  # print text_4
    syscall                         # call command print


    li $v0, 1                       # print int
    add $a0, $0, $t4                # print result
    syscall                         # call command print

    li $v0, 4                       # print string
    la $a0, text_2                  # print text_2
    syscall                         # call command print

    li $v0, 10                      # exit
    syscall                         # call command exit