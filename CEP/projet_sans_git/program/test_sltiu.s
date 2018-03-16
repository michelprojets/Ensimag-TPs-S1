.text
# Pour les tests ne pas utiliser le registre $1
lui $24, 0xFFFE
lui $25, 0xFFFF
sltiu $28, $24, 0xFFFF
sltiu $28, $25, 0xFFFE

ori $15,$0, 0x0001
ori $16, $0, 0x0002
sltiu $28, $15, 0x0002
sltiu $28, $16, 0x0001

lui $17, 0xFFFE
lui $18, 0x0002
sltiu $28, $17, 0x0002
sltiu $28, $18, 0xFFFE

# max_cycle 100
# pout_start
# 00000001
# 00000001
# 00000001
# 00000000
# 00000000
# 00000001
# pout_end
