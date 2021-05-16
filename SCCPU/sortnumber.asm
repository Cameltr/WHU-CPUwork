lui $2, 0x0113 
ori $2, $2, 0x2005
sw $2, 0x100($0) 
addi $11, $0, 8 
lw $1, 0x100($0) 
add $2, $0, $0 
addi $4, $0, 0x0f 

loop1:
and $7, $1, $4 
sll $9, $2, 2 
srlv $7, $7, $9 
sll $5, $4, 4 
add $12, $2, $0 
add $13, $7, $0 
addi $3, $2, 1

loop2:
beq $3, $11, checkswap 
and $8, $1, $5 
sll $10, $3, 2 
srlv $8, $8, $10 
slt $14, $13, $8 
beq $14, $0, incrLoop2 
add $13, $8, $0 
add $12, $3, $0

incrLoop2:
sll $5, $5, 4 
addi $3, $3, 1 
j loop2

checkswap:
slt $14, $2, $12 
beq $14, $0, incrLoop1
jal swap

incrLoop1:
sll $4, $4, 4 
addi $2, $2, 1 
bne $2, $11, loop1 

result:
sw $1, 0x104($0) 
lui $2, 0xffff 
j result

swap: 
addi $5, $0, 0x0f
sll $10, $12, 2 
sllv $5, $5, $10 
or $6, $4, $5 
nor $6, $6, $0 
and $1, $1, $6 
sllv $8, $13,$9 
or $1, $1, $8 
sllv $7, $7, $10 
or $1, $1, $7 
jr $31
