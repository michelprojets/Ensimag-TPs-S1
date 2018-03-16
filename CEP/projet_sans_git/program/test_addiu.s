.text
# Pour les tests ne pas utiliser le registre $1

lui $16, 0x00
ori $19, $16, 0x01 	
addiu $28, $19, 0x02

lui $26, 0xFFFF
ori $27, $26, 0xFF6A
addiu $28, $27, 0xFF6A
# max_cycle 50
# pout_start
# 00000003
# FFFFFED4
# pout_end
