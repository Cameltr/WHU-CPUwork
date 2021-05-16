main:   addi $2, $0, 5
ori  $3, $0, 12
subu $1, $3, $2
srl  $7, $1, 1
call_a: j    a
nop									
or   $4, $7, $2
and  $5, $3, $4
add  $5, $5, $4
beq  $5, $7, end
nop
sltu $4, $3, $4
beq  $4, $0, around
nop
addi $5, $0, 0
addi $5, $0, 0
addi $5, $0, 0
around: slt  $4, $7, $2
addu $7, $4, $5
sub  $7, $7, $2
sw   $7, 68($3)
lw   $2, 80($0)
j    end
nop
addi $2, $0, 1
a:      sll  $7, $7, 2
call_b: jal  b
nop
addi $31,$0,24
jalr   $31
nop
b:      lui  $1, 0xFFAA
slt  $1, $7, $1
bne  $1, $0, end
nop
sub  $7, $7, $2
srl  $7, $7, 1
nor  $1, $7, $1
sltu $1, $1, $7
jr   $31
nop
end:    sw   $3, 84($0)
lw   $7, 72($3)	
sw   $7, 68($3)
lw   $6, 68($3)
add  $6, $6, $5
slti $8, $1, 2
andi $9, $2, 5
sllv $10, $2, $4
loop:   j    loop
nop

# $0  = 0  # $1  = 0  # $2  = 7   # $3  = c
# $4  = 1  # $5  = b  # $6  = 17h # $7  = c
# $8  = 1  # $9  = 5  # $10 = e
# $31  = 78h