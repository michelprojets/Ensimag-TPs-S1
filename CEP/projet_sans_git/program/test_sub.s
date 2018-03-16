.text
# Pour les tests ne pas utiliser le registre $1

lui $16, 0x00
ori $19, $16, 0x01 	
ori $20, $16, 0x02
sub $28, $19, $20
# max_cycle 50
# pout_start
# FFFFFFFF
# pout_end
