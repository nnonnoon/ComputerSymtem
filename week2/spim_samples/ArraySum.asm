#This MIPS assembly program translates from the following C snippet

.data # data section

array_a: .word 0, 1, 2, 3, 4, 5, ,6 ,7 ,8 ,9 ,10 ,11 ,12, 13, 14 ,15 ,16 ,17 ,18, 19
array_b: .word 0x7fffffff, 0x7ffffffe, 0x7ffffffd, 0x7ffffffc, 0x7ffffffb, 0x7ffffffa, 0x7ffffff9, 0x7ffffff8, 0x7ffffff7, 0x7ffffff6

output_prompt1: .asciiz "Sum a = "
output_prompt2: .asciiz "Sum b = "
new_line: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

main:
la $8 ,array_a
la $9 ,array_b

addi $10,$0,0   #i = 0
addi $11,$0,0   #sum = 0

loop_1:
    slti $12,$10,20 # if(!(i<20))
    beq $12,$0,print_1 # $12==0 goto loop_1
    sll $13,$10,2  # i*4
    add $13,$8,$13 # a[i+1]=a[i]+i*4
    lw  $14,0($13) # load a[i]
    add $11,$11,$14 # sum+=a[i]
    addi $10,$10,1  #i=i+1
    j loop_1

print_1:
    li $v0,4
    la $a0 , output_prompt1
    syscall
    li $v0 , 1
    add  $a0, $0 , $11
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

addi $10,$0,0
addi $11,$0,0

loop_2:
    slti $12,$10,10 # if(!(i<10))
    beq $12,$0,print_2 # $12==0 goto loop_1
    sll $13,$10,2  # i*4
    add $13,$9,$13 # b[i+1]=b[i]+i*4
    lw  $14,0($13) # load b[i]
    addu $11,$11,$14 # sum+=b[i]
    addi $10,$10,1  #i=i+1
    j loop_2

print_2:
    li $v0,4
    la $a0 , output_prompt2
    syscall
    li $v0 , 1
    addu  $a0,$0,$11
    syscall
    li $v0, 4
    la $a0, new_line
    syscall

li	$v0 ,10
syscall