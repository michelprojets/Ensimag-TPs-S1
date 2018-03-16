.text
# Pour les tests ne pas utiliser le registre $1

lui $25, 0x0001
	
jal popo
lui $10, 0x1100	
sumo :
	sub $25, $25, $25
	jalr $18, $20

popo :
        lui $26, 0x0001
	add $28, $26, $25
	add $26, $31, $15
	jalr $20, $31
	lui $19, 0x2220

	
# max_cycle 50
# pout_start
# 00020000
# pout_end


	


