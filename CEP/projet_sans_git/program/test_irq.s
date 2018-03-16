.text
.org 0
progPrincipal:
or $2,$0,$0        

boucle_infinie:
addi $2,$2,1       

or $28,$2,$0       # Sort la valeur du compteur sur le port (=$28)
j boucle_infinie  
traitantIT:
ori $2,$0,33       # En cas d’interruption le compteur est ici modifie pour voir que
eret               #     l’interruption a bien  ́et ́e prise en compte
.org 0x1FFC        # Si une interruption arrive le processeur va `a l’adresse 0x1FFC
j traitantIT
