.text
# Pour les tests ne pas utiliser le registre $1

lui $24, 0x0001
lui $25, 0x0002

bne $25, $24, popo
	
sumo :
	add $25, $25, $25
	bne $25, $25, popo      

popo :
        lui $26, 0x0001
	add $28, $26, $25
	bne $28, $26, sumo
	
# max_cycle 50
# pout_start
# 00030000
# pout_end




	


