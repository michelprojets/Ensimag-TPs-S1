.text
# Pour les tests ne pas utiliser le registre $1
lui $16, 0x00
ori $19, $16, 0x08
srl $28, $19, 0x01
	
lui $26, 0x8000
ori $27, $26, 0x08
srl $28, $27, 0x01
# max_cycle 50
# pout_start
# 00000004
# 40000004
# pout_end
