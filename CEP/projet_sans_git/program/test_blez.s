.text
# Pour les tests ne pas utiliser le registre $1
ori $24, $23, 0x0001
ori $25, $23, 0x0004
sub $25, $24, $25

blez $25, popo
	
sumo :
	add $25, $25, $25
	blez $25, popo      

popo :
        ori $26, $23, 0x0001
	sub $28, $26, $24
	blez $28, sumo
	
# max_cycle 50
# pout_start
# 00000000
# pout_end




	


