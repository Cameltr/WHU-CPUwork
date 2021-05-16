L0:	ori $2, $0, 0x1234
	addu $3, $2, $2
	beq $2, $3,L0
	subu $4, $3, $2
	beq $2, $4,L0
	
	
	
	