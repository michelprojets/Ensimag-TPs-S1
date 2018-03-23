/*
uint32_t age(uint32_t annee_naissance)
{
    uint32_t age;
    age = 2016 - annee_naissance;
    return age;
}
*/

    .text
    .globl age
    /* uint32_t age(uint32_t annee_naissance) */

/* Contexte imposé :
    annee_naissance : registre $a0
    uint32_t age : pile à SP+0

    place paramètres : np=1
    pas de place pour variable locale car fonction feuille
    place registre ra : nr=1
    => N=2*4 donc pile +2*4
    PILE:
    sp+0 : place pour age
    sp+4 : place pour $ra
*/

age:
/* A compléter */
    /* on reserve la place nécessaire dans la pile */
    addiu $sp,$sp,-2*4
    /* on y sauvegarde l'adresse de retour */
    sw $ra, 4($sp)
    /* uint32_t age; */
    li $t0, 0
    /* age = 2016 - annee_naissance; */
    li $t1, 2016
    subu $t0, $t1, $a0
    /* on sauvegarde l'age dans la pile */
    sw $t0, 0($sp)
    /* ... */
    /* on récupère l'age dans la pile */
    lw $t0, 0($sp)
    /* return age; */
    move $v0, $t0
    /* on récupère l''adresse de retour' */
    lw $ra, 4($sp)
    /* on replace le pointeur de pile */
    addiu $sp,$sp,2*4
    /* on retourne à l'instruction suivante du programme appelant */
    jr $ra
