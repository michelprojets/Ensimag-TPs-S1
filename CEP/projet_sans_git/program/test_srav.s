.text
# Pour les tests ne pas utiliser le registre $1
lui $16, 0x00
ori $19, $16, 0x08
ori $20, $16, 0x01 
srav $28, $19, $20
	
lui $26, 0x8000
ori $27, $26, 0x08
srav $28, $27, $20
# max_cycle 50
# pout_start
# 00000004
# C0000004
# pout_end
