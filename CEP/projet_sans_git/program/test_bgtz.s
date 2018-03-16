.text
# Pour les tests ne pas utiliser le registre $1
ori $24, $23, 0x0004
ori $25, $23, 0x0001
sub $25, $24, $25

bgtz $25, popo
	
sumo :
	add $25, $25, $25
	bgtz $25, popo     

popo :
        ori $26, $23, 0x0001
	sub $28, $25, $26
	bgtz $28, sumo
	
# max_cycle 50
# pout_start
# 00000002
# pout_end




	


