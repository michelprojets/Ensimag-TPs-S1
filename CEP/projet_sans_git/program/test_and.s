.text
# Pour les tests ne pas utiliser le registre $1

lui $16, 0x00
ori $19, $16, 0x01 	
ori $20, $16, 0x02
and $28, $19, $20
	
ori $21, $16, 0xFF 	
ori $22, $16, 0x01
and $28, $21, $22
# max_cycle 50
# pout_start
# 00000000	
# 00000001
# pout_end
