.text
# Pour les tests ne pas utiliser le registre $1
	
lui $25, 0x0001
	
ori $14, $16, popo
jr $14
	
sumo :
	sub $25, $25, $25      

popo :
        lui $26, 0x0001
	add $28, $26, $25
	
# max_cycle 50
# pout_start
# 00020000
# pout_end



	


