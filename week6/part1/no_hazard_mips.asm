main:
    addiu   $t0, $zero, 5           #5                      # $t0 = 0 + 5
    addiu   $t1, $zero, 7           #6                      # $t1 = 0 + 7
    addiu   $s0, $zero, 9           #7                      # $s0 = 0 + 9
    addiu   $s1, $zero, 2           #8                      # $s1 = 0 + 2
    addu 	$s5, $zero, $zero  	    #9		                # $s5 = 0 + 0
    addiu	$s6, $zero, 5  	        #10		                # $s6 = 0 + 4
    jal func_plus                   #11
    nop
    sll $t2, $t0, 1                 #128
    srl $t2, $t0, 1                 #129
    sra $t2, $t0, 1                 #130
    j 0x200000                      #131
func_plus:
    addu $s2, $s0, $s1              #12                     # $s2 = $s0 + $s1 = 11 (b)
    addu $t2, $t0, $t1              #13                     # $t2 = $t0 + $t1 = 12 (c)
    nop
    nop
    nop
    sltiu $t3, $t2, 20              #16                     # if $t2 < 20 then $t3 = 1,else 0
    nop
    nop
    nop
    beq  $t3, $zero, bistwise_2                             # if $t3 != 0 then go to exit
    nop
    slti $t3, $t2, 4                                        # if $t2 < 4 then $t3 = 1,else 0
    subu $t2, $t0, $t1              #21                     # $t2 = $t0 - $t1 = -2
    nop
    nop
    nop
    sltu $t3, $t2, $t0                                      # if $t2 < $t0 then $t3 = 1,else 0
    nop
    nop
    nop
    bne $t3, $zero, bistwise                                # if $t3 != 0 then go to bistwise
    nop
    slt $t3, $t0, $t1                                       # if $t0 < $t1 then $t3 = 1,else 0
    nop
    nop
    nop
    bne $t3, $zero, bistwise        #31                     # if $t3 = 0 then go to bistwise

load_store:
    addiu $sp, $sp, -8              #37 #56 #75 #94 #113    # add strack
    sw $t0, 4($sp)                                          # store $t0 in 0($sp)
    sw $t1, 0($sp)                                          # store $t1 in 0($sp)
    nop
    nop
    lw $t3, 4($sp)                                          # load $t0 to $t3
    lw $t4, 0($sp)                                          # load $t1 to $t4
    addiu $sp, $sp, 8                                       # return strack
    j bistwise_2                    #45 #64 #83 #102 #121

bistwise:
    and $t4, $t0, $t1               #32 #51 #70 #89 #108
    or  $t5, $t0, $t1               #33
    xor $t6, $t0, $t1               #34
    nor $t7, $t0, $t1               #35
    j load_store                    #36 #55 #74 #93 #112


bistwise_2:
    andi $t4, $t0, 12               #46 #65 #84 #103 #122
    ori  $t5, $t0, 13
    xori $t6, $t0, 14
    addiu $s5, $s5, 1                #49  #68 #87 #106 #125
    bne  $s5, $s6, bistwise         #50 #69 #88 #107 #126
    nop
    jr $ra                          #127
    nop