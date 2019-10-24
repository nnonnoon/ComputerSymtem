.data
.text
.globl main




func_plus:
    addu $t2, $t0, $t1           # $t2 = $t0 + $t1 = 12 (c)
    addu $s2, $s0, $s1           # $s2 = $s0 + $s1 = 11 (b)
    sltiu $t3, $t2, 20           # if $t2 < 20 then $t3 = 1,else 0
    beq $t3, $zero, bistwise_2   # if $t3 != 0 then go to exit
    slti $t3, $t2, 4             # if $t2 < 4 then $t3 = 1,else 0
    subu $t2, $t0, $t1           # $t2 = $t0 - $t1 = -2
    sltu $t3, $t2, $t0           # if $t2 < $t0 then $t3 = 1,else 0
    bne $t3, $zero, bistwise     # if $t3 != 0 then go to bistwise
    slt $t3, $t0, $t1            # if $t0 < $t1 then $t3 = 1,else 0
    bne $t3, $zero, bistwise     # if $t3 = 0 then go to bistwise

load_store:
    addiu $sp, $sp, -8           # add strack
    sw $t0, 4($sp)               # store $t0 in 0($sp)
    sw $t1, 0($sp)               # store $t1 in 0($sp)
    lw $t3, 4($sp)               # load $t0 to $t3
    lw $t4, 0($sp)               # load $t1 to $t4
    addiu $sp, $sp, 8            # return strack
    j bistwise_2

bistwise:
    and $t4, $t0, $t1
    or $t5, $t0, $t1
    xor $t6, $t0, $t1
    nor $t7, $t0, $t1
    j load_store


bistwise_2:
    andi $t4, $t0, 12
    ori $t5, $t0, 13
    xori $t6, $t0, 14
    jr $ra

main:
    addiu   $t0, $zero, 5       # $t0 = 0 + 5
    addiu   $t1, $zero, 7       # $t1 = 0 + 7
    addiu   $s0, $zero, 9       # $s0 = 0 + 9
    addiu   $s1, $zero, 2       # $s1 = 0 + 2

    jal func_plus
    sll $t2, $t0, 1
    srl $t2, $t0, 1
    sra $t2, $t0, 1
    li $v0,10
    syscall




