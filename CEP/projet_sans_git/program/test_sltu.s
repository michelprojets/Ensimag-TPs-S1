.text
# Pour les tests ne pas utiliser le registre $1

lui $24, 0xFFFE
lui $25, 0xFFFF
sltu $28, $24, $25
sltu $28, $25, $24
	
lui $24, 0x0001
lui $25, 0x0002
sltu $28, $24, $25
sltu $28, $25, $24

lui $24, 0xFFFE
lui $25, 0x0002
sltu $28, $24, $25
sltu $28, $25, $24

# max_cycle 100
# pout_start
# 00000001
# 00000000
# 00000001
# 00000000
# 00000000
# 00000001
# pout_end




	


