.text
# Pour les tests ne pas utiliser le registre $1

lui $17, 0x00
ori $19, $17, 0xFF 	
ori $20, $17, 0xFF
nor $28, $19, $20
	
ori $21, $17, 0x00 	
ori $22, $17, 0x01
nor $28, $21, $22
	
# max_cycle 50
# pout_start
# FFFFFF00
# FFFFFFFE
# pout_end
