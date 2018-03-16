.text
# Pour les tests ne pas utiliser le registre $1
lui $16, 0x00
ori $19, $16, 0x01
xori $28, $19, 0x03
	
ori $21, $16, 0x03 	
xori $28, $21, 0x03
# max_cycle 50
# pout_start
# 00000002
# 00000000
# pout_end
