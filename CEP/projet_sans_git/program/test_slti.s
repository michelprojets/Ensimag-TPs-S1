.text
# Pour les tests ne pas utiliser le registre $1
ori $24, $23, 0x0004
slti $28, $24, 0x0001
	
ori $24, $23, 0x0001
slti $28, $24, 0x0004

# max_cycle 50
# pout_start
# 00000000
# 00000001
# pout_end




	


