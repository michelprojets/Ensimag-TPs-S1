.text
# Pour les tests ne pas utiliser le registre $1 
debut:	
	lui $25, 0x1234
	lw $26, toto($0)
	lw $28, vars($0)
	j popo

popo:
	lui $24, 0x4321
	j popo
	
.data
vars:	.word 6

toto:	.word 8
	
# max_cycle 50
# pout_start
# 00000006
# pout_end
