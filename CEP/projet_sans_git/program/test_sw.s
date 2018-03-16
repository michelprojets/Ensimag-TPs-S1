.text
# Pour les tests ne pas utiliser le registre $1 

ori $25, 0x0005
sw $25, 0x00AB($0)
lw $28, 0x00AB($0)
	
# max_cycle 50
# pout_start
# 00000005
# pout_end
