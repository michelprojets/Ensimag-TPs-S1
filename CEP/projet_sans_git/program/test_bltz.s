.text
# Pour les tests ne pas utiliser le registre $1
ori $24, $23, 0x0001
ori $25, $23, 0x0004
sub $25, $24, $25

bltz $25, popo
	
sumo :
	sub $25, $25, $25
	bltz $25, sumo     

popo :
        ori $26, $23, 0x0002
	sub $28, $24, $26
	bltz $28, sumo
	
# max_cycle 50
# pout_start
# FFFFFFFF
# pout_end




	


