.text
# Pour les tests ne pas utiliser le registre $1
ori $24, $23, 0x0004
ori $25, $23, 0x0001
slt $28, $24, $25
	
ori $24, $23, 0x0001
ori $25, $23, 0x0004
slt $28, $24, $25

# max_cycle 50
# pout_start
# 00000000
# 00000001
# pout_end




	


