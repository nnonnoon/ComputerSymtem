.data # data section

array_a: .word 0, 2, 1, 6, 4, 3, 5, 3 # data for addition
array_b: .word 0, 0, 0, 0, 0, 0, 0, 0 # data for addition
array_c: .word 0, 0, 0, 0, 0, 0, 0    # data for addition

text_1: .asciiz "A[] = " #define string
text_2: .asciiz " "      #define string
text_3: .asciiz "\n"     #define string
text_4: .asciiz "B[] = " #define string


.text # text section

.globl main # call main by SPIM

main:

la $8, array_a              # load address a into $8
la $9, array_b              # load address b into $9
la $10, array_c             # load address c into $10

addi $11, $0, 8             # n is $11 = 8
addi $12, $0, 7             # k is $12 = 7
addi $13, $0, 1             # i is $13 = 1


loop_1:
    slt  $14, $13, $11      # if(i<n)
    beq  $14,  $0, endloop1 # if $14 == 0 go to loop_2
    sll  $17, $13, 2        # $17 keep i*4
    add  $17,  $8, $17      # calculate address of A[i]
    lw   $18, 0($17)        # load  A[i] to $18
    sll  $19, $18, 2        # $18 keep i*4
    add  $19,  $10, $19     # calculate address of C[A[i]]
    lw   $20, 0($19)        # load  C[A[i]] to $20
    addi $20, $20, 1        # C[A[i]] = C[A[i]] + 1
    sw   $20, 0($19)        # store C[A[i]]+1 to C[A[i]]
    addi $13 , $13, 1       # i = i + 1
    j loop_1
endloop1:
    addi $13, $0 ,2         #  i is $13 = 2

loop_2:
    slt  $14, $13, $12      # if(i<k)
    beq  $14, $0, endloop2  # if $14 == 0 go to loop_3
    sll  $17, $13, 2        # $17 keep i*4
    add  $17, $10, $17      # calculate address of C[i]
    lw   $18, 0($17)        # load C[i] to $18
    addi $19, $17, -4       # $19 keep i*(-4)
    lw   $20, 0($19)        # load C[i-1] to $20
    add  $21, $18, $20      # calculate C[i] + C[i-1]
    sw   $21, 0($17)        # store $21 to C[i]
    addi $13, $13, 1        # i = i + 1
    j loop_2
endloop2:
    addi $13, $11, -1       # i = n - 1

loop_3:
    slti $16, $13, 1        # if (i<1)
    bne  $16, $0, print_1   # if  $16 != 0 go to print_1
    sll  $17, $13, 2        # $17 keep i*4
    add  $17,  $8, $17      # calculate address of A[i]
    lw   $18, 0($17)        # load  A[i] to $18
    sll  $19, $18, 2        # $18 keep i*4
    add  $19, $10, $19      # calculate address of C[A[i]]
    lw   $20, 0($19)        # load  C[A[i]] to $20
    sll  $21, $20, 2        # $18 keep i*4
    add  $21, $9, $21       # calculate address of B[C[A[i]]]
    sw   $18, 0($21)        # store $18 to B[C[A[i]]]s
    addi $23, $20, -1       # keep $20 - 1 to $23
    sw   $23, 0($19)        # store $23 to C[A[i]]
    addi $13, $13 , -1      # i = i-1
    j loop_3

print_1:
    li $v0, 4               # print string
    la $a0, text_1          # print text_1 is A[] =
    syscall
    li $v0, 4               # print string
    la $a0, text_3          # print text_3
    syscall                 # call command print

add $13, $0, $0             # i = 0
loop_4:
    slt  $14, $13, $11      # if(i<n)
    beq  $14, $0, print_2   # if $14 == 0 go to print_2
    sll  $17, $13, 2        # $17 keep i*4
    add  $17,  $8, $17      # calculate address of A[i]
    lw   $18, 0($17)        # load  A[i] to $18
    li   $v0, 4             # print string
    la   $a0, text_2        # print text_2
    syscall                 # call command print
    li   $v0, 1             # print string
    add  $a0, $0, $18       # print A[i]
    syscall                 # call command print
    addi $13, $13, 1        # i = i + 1
    j loop_4
print_2:
    li $v0, 4               # print string
    la $a0, text_3          # print text_3
    syscall                 # call command print
    li $v0, 4               # print string
    la $a0 ,text_4          # print text_4
    syscall                 # call command print
    li $v0, 4               # print string
    la $a0, text_3          # print text_3
    syscall                 # call command print


add $13, $0, $0             # i = 0
loop_5:
    slt  $14, $13, $11      # if(i<n)
    beq  $14, $0, print_3   # if $14 == 0 go to print_3
    sll  $17, $13, 2        # $17 keep i*4
    add  $17,  $9, $17      # calculate address of B[i]
    lw   $18, 0($17)        # load  B[i] to $18
    li   $v0, 4             # print string
    la   $a0, text_2        # print text_2
    syscall                 # call command print
    li   $v0, 1             # print string
    add  $a0, $0, $18       # print B[i]
    syscall                 # call command print
    addi $13, $13, 1        # i = i + 1
    j loop_5
print_3:
    li $v0, 4               # print string
    la $a0, text_3          # print text_3
    syscall                 # call command print

li $v0, 10                  # exit
syscall                     # call command exit