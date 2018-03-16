.text
# Pour les tests ne pas utiliser le registre $1
	
lui $16, 0x00
ori $19, $16, 0x01 	
ori $20, $16, 0x02
addU $28, $19, $20

lui $26, 0xFFFF
ori $27, $26, 0xFF6A
ori $28, $26, 0xFF6A
addu $28, $27, $28
# max_cycle 50
# pout_start
# 00000003
# FFFFFF6A
# FFFFFED4
# pout_end
