Nous avons implanté toutes les instructions des séances :
1, 2, 3, 4 et 5
ORI, LUI
ADD, ADDI, ADDU, ADDIU, AND, ANDI, NOR, OR, XOR, XORI, SUB, SUBU, SLL, SLLV, SRL, SRA, SRAV, SRLV
J, JR, BEQ, BNE, BLEZ, BGTZ, BGEZ, BLTZ, JAL, JALR, BLTZAL, BGEZAL
LW, SW, SLT, SLTI, SLTU, SLTIU
PO : interruption 1 source, ERET
Cependant, l'interruption et ERET n'ont pas été validés même si on les a implémenté.
Nous n'avons pas implémenté d'extentions

Dans le répertoire "program", nous avons écrit des tests en assembleur pour chaque instruction
(sauf pour le programme d'interruption et ERET)

Le fichier autotest_res permet de lancer tous nos tests automatiquement.

Un de nos tests échoue : "test_lw.s".
On ne comprend pas du tout pourquoi alors que lorsqu'on regarde
avec la simulation, le registre $28 contient bien la même valeur que celle spécifiée dans ce qui
était prévu dans le test en question. (De plus, l'application automatique l'a correctement validé).
