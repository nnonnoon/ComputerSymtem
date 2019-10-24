.data # data section
array_a: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 # data for addition
array_b: .word 0x7fffffff, 0x7ffffffe, 0x7ffffffd, 0x7ffffffc, 0x7ffffffb, 0x7ffffffa, 0x7ffffff9, 0x7ffffff8, 0x7ffffff7, 0x7ffffff6 # data for addition
utput_prompt1: .asciiz "Sum a = " #define string
utput_prompt2: .asciiz "Sum b = " #define string
new_line: .asciiz "\n" #define string
.text # text section

.globl main # call main by SPIM

main:
la $8, array_a              # load address a into $8
la $9, array_b              # load address b into $9



addi $10, $0, 0             # i is $10 = 0
addi $11, $0, 0             # sum is $11 = 0
loop1:
    slti $12,$10, 20        # if i<20
    beq	$12, $0, print1	    # if $12 == 0 go to print1
    sll $13, $10, 2         # $13 keep i*4
    add $13, $8, $13        # calculate address of a[k]
    lw $14, 0($13)          # load a[k] to $14
    add $11, $11, $14       # sum+=a[i]
    addi $10, $10, 1        # i = i + 1
    j loop1                 # go to loop1


print1:
    li	$v0, 4              # print string
    la	$a0, utput_prompt1  # print utput_prompt1
    syscall                 # call command print
    li	$v0, 1              # print int
    add	$a0, $0 ,$11        # print sum b
    syscall                 # call command print
    li	$v0, 4              # print string
    la	$a0, new_line       # print new_line
    syscall                 # call command print


addi $10, $0, 0             # i is $10 = 0
addi $11, $0, 0             # sum is $11 = 0
loop2:
    slti $12,$10, 10        # if i<10
    beq	$12, $0, print2	    # if $12 == 0 go to print2
    sll $13, $10, 2         # $13 keep i*4
    add $13, $9, $13        # calculate address of a[k]
    lw $14, 0($13)          # load b[k] to $14
    addu $11, $11, $14      # sum+=a[i]
    addi $10, $10, 1        # i=i+1
    j loop2                 # go to loop2

print2:
    li	$v0, 4              # print string
    la	$a0, utput_prompt2  # print utput_prompt2
    syscall                 # call command print
    li	$v0, 1              # print int
    addu $a0, $0, $11       # print sum b
    syscall                 # call command print
    li	$v0, 4              # print string
    la	$a0, new_line       # print new_line
    syscall                 # call command print



li	$v0, 10                 # exit
syscall                     # call command exit
