.data # data section

text_1: .asciiz "\n"
text_2: .asciiz " "
.text # text section

.globl main # call main by SPIM

insertionSortRecursive:
    addi $sp, $sp , -8                  # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)                      # store $ra to stack
    sw $fp, 0($sp)                      # store $fp to stack
    addu $fp, $zero, $sp                # set $fp to the current value of $sp (top of stack)

    lw $s1, 12($fp)                     # load n = 12 to $s1
    lw $s0, 8($fp)                      # load base_array_1 to $s0

    li $s2, 1                           # $s2 = 1

    slt $s3, $s2, $s1                   # if ( 1 < n ) then $s3 = 1 else $s3 = 0
    beq $s3, $0, exit_2                 # if $s3 == 0 go to exit_2
    addi $s1, $s1, -1                   # $s1 = $s1 - 1
    addi $sp, $sp, -8                   # reserve space for the two local variables array_1 and 12
    sw $s1, 4($sp)                      # store $s1 to store
    sw $s0, 0($sp)                      # store $s0 to store
    jal insertionSortRecursive          # jal insertionSortRecursive
    # lw $s1, 4($sp)                      # load $s1 from stack
    # lw $s0, 0($sp)                      # load $s0 from stack
    addi $sp, $sp , 8                   # deallocate the stack memory

    lw $s1, 12($fp)                     # load n = 12 to $s1
    lw $s0, 8($fp)                      # load base_array_1 to $s0

    addi $s4, $s1, -1                   # n - 1
    sll $s5, $s4, 2                     # $s4 * 4
    add $s5, $s0, $s5                   # calculate address of arr[i] &arr[n-1] = &arr[0] + (n-1) * 4
    lw $s6, 0($s5)                      # load arr[n-1] to $s6 = last

    addi $s7, $s1, -2                   # $s7 = n - 2 = j

    lw $s1, 12($fp)                     # load n = 12 to $s1
    lw $s0, 8($fp)                      # load base_array_1 to $s0

    loop_2:
        slt $s5, $s7, $0                # if ( j < 0) then $s5 = 1 else $s5 = 0
        sll $s3, $s7, 2                 # $s7 * 4
        add $s3, $s0, $s3               # calculate address of arr[j] &arr[j] = &arr[0] + (j) * 4
        lw  $s2, 0($s3)                 # load arr[j] to $s2
        slt $s4, $s6, $s2               # if (last < arr[j]) then $s4 = 1 else $s4 = 0
        nor $s5, $s5, $0                # $s5 nor $0
        and $t3, $s5, $s4               # $t3 = $s5 and $s4
        beq $t3, $0, terminate          # if ( $t3 == 0 ) go to terminate

        addi $t4, $s7, 1                # $t4 = $s7 + 1
        sll $t5, $t4, 2                 # $t4 * 4
        add $t5, $s0, $t5               # calculate address of arr[j] &arr[j] = &arr[0] + (j+1) * 4
        sw $s2, 0($t5)                  # store arr[j+1] to $s2
        addi $s7, $s7, -1               # $s7 = $s7 -1
        j loop_2                        # jump to loop_2

    terminate:
        addi $t7, $s7, 1                # $t7 = $s7 + 1 = j + 1
        sll $t8, $t7, 2                 # $t8 = j * 4
        add $t5, $s0, $t8               # $t5 = $t8
        sw $s6, 0($t5)                  # arr[j+1] = last

        lw $ra, 4($sp)                  # restore $ra
        lw $fp, 0($sp)                  # restore $fp
        addi $sp, $sp , 8               # deallocate the stack memory
        jr $ra                          # jump to an instruction at the address specified in $ra whose value

    exit_2:
        lw $ra, 4($sp)                  # restore $ra
        lw $fp, 0($sp)                  # restore $fp
        addi $sp, $sp , 8               # deallocate the stack memory
        jr $ra                          # jump to an instruction at the address specified in $ra whose value



printArray:
    addi $sp, $sp , -8                  # reserve space for the two local variables $ra and $fp
    sw $ra, 4($sp)                      # store $ra to stack
    sw $fp, 0($sp)                      # store $fp to stack
    addu $fp, $zero, $sp                # set $fp to the current value of $sp (top of stack)

    lw $s0, 8($fp)                      # load base_array_1 to $s0
    lw $s1, 12($fp)                     # load n = 12 to $s1

    li $s2, 0                           # $s2 = 0 = i

    loop_1:
        slt $s3, $s2, $s1               # if (i < n)
        beq $s3, $0, exit_1             # if $s3 == 0 go to exit_1
        sll $s4, $s2, 2                 # $s0 keep i*4
        add $s4, $s0, $s4               # calculate address of arr[i] &arr[i-1] = &arr[0] + (i) * 4
        lw $s5, 0($s4)                  # load arr[u] to $s5
        li $v0, 1                       # print int
        add $a0, $0, $s5                # print array_1
        syscall                         # call command print
        addi $s2, $s2, 1                # $s2 = $s2 + 1
        li $v0, 4                       # print string
        la $a0, text_2                  # print text_2
        syscall                         # call command print
        j loop_1                        # jump to loop_1


    exit_1:
        li $v0, 4                       # print string
        la $a0, text_1                  # print text_1
        syscall                         # call command print
        lw $ra, 4($sp)                  # restore $ra
        lw $fp, 0($sp)                  # restore $fp
        addi $sp, $sp , 8               # deallocate the stack memory
        jr $ra                          # jump to an instruction at the address specified in $ra whose value



main:
    add $sp, $sp, -48                   # reserve space for the twelve local variables array_1
    li $t0, 132470                      # $t0 = 132470
    sw $t0, 0($sp)                      # store $to to stack

    li $t0, 324545                      # $t0 = 324545
    sw $t0, 4($sp)                      # store $to to stack

    li $t0, 73245                       # $t0 = 73245
    sw $t0, 8($sp)                      # store $to to stack

    li $t0, 93245                       # $t0 = 93245
    sw $t0, 12($sp)                     # store $to to stack

    li $t0, 80324542                    # $t0 = 80324542
    sw $t0, 16($sp)                     # store $to to stack

    li $t0, 244                         # $t0 = 244
    sw $t0, 20($sp)                     # store $to to stack

    li $t0, 2                           # $t0 = 2
    sw $t0, 24($sp)                     # store $to to stack

    li $t0, 66                          # $t0 = 66
    sw $t0, 28($sp)                     # store $to to stack

    li $t0, 236                         # $t0 = 236
    sw $t0, 32($sp)                     # store $to to stack

    li $t0, 327                         # $t0 = 327
    sw $t0, 36($sp)                     # store $to to stack

    li $t0, 236                         # $t0 = 236
    sw $t0, 40($sp)                     # store $to to stack

    li $t0, 21544                       # $t0 = 21544
    sw $t0, 44($sp)                     # store $to to stack

    add $t2, $sp, $0                    # $t2 = $sp
    li $t1, 12                          # $t1 = 12

    add $sp, $sp, -8                    # reserve space for the two local variables 12
    sw $t1, 4($sp)                      # store $t1 to stack
    sw $t2, 0($sp)                      # store $t2 to stack
    jal printArray                      # jump to link to printArray
    addi $sp, $sp, 8                    # deallocate the stack memory

    add $t2, $sp, $0                    # $t2 = $sp
    li $t1, 12                          # $t1 = 12

    addi $sp, $sp, -8                   # reserve space for the two local variables array_1 and 12
    sw $t1, 4($sp)                      # store $t1 = 12  to stack
    sw $t2, 0($sp)                      # store $t2 = array_1 to stack
    jal  insertionSortRecursive         # jump to link to insertionSortRecursive
    addi $sp, $sp, 8                    # deallocate the stack memorys

    add $t2, $sp, $0                    # $t2 = $sp
    li $t1, 12                          # $t1 = 12

    add $sp, $sp, -8                    # reserve space for the two local variables 12
    sw $t1, 4($sp)                      # store $t1 to stack
    sw $t2, 0($sp)                      # store $t2 to stack
    jal printArray                      # jump to link to printArray
    addi $sp, $sp, 8                    # deallocate the stack memory

    addi $sp, $sp, 48                   # deallocate the stack memory


    li $v0, 10                          # exit
    syscall                             # call command exit