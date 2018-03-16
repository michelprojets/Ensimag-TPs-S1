.text
# Pour les tests ne pas utiliser le registre $1

ori $24, $23, 0x0001
ori $25, $23, 0x0004
sub $25, $24, $25

bltzal $25, popo

sumo :
	sub $25, $25, $25

popo :
        ori $26, $23, 0x0002
	sub $28, $24, $26
	jalr $20, $31

# max_cycle 50
# pout_start
# FFFFFFFF
# pout_end



	


