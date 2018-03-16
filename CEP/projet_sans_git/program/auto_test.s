.text
# Pour les tests ne pas utiliser le registre $1
lui $16, 0xABCD
ori $28, $16, 0x1234
# max_cycle 50
# pout_start
# ABCD0000	
# ABCD1234
# pout_end
