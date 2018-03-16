.text
# Pour les tests ne pas utiliser le registre $1

lui $24, 0x0001
lui $25, 0x0001

beq $25, $24, popo
	
sumo :
	add $25, $23, $25      

popo :
        lui $26, 0x0001
	add $28, $26, $25
	beq $28, $26, sumo
	
# max_cycle 50
# pout_start
# 00020000
# pout_end




	


