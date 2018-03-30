/*
uint32_t taille_chaine(const char *chaine)
{
    uint32_t taille=0;
    while (chaine[taille] != '\0'){
        taille++;
    }
    return taille;
}
*/
    .text
    .globl taille_chaine
/* uint32_t taille_chaine(const char *chaine) */
/* Contexte :
    Fonction feuille (pas de modif de pile à faire)
    place param : np=0
    place pour variables locales : nv=0
    place registre ra : nr=0
    => N=0*4 donc pile +0*4
    chaine : registre $a0, param de type (const char *)
    taille : registre $t0, var locale de type (uint32_t)
*/

taille_chaine:
    /* uint32_t taille=0; */
    lui $t0, 0
    /* while (chaine[taille] != '\0'){*/
while :
        /* on calcule l'adresse correspondant à la case du tableau à l'index voulu */
        /* &chaine[taille]
        /* pas besoin de mult car un char est sur un octet */
        and $t1, $t1, $zero
        addu $t1, $a0, $t0
        lbu $t2, 0($t1)
        beq $t2, $zero, fin_while
        /* taille++; */
        addiu $t0, $t0, 1
        /* } */
        j while
fin_while :
            /* return taille; */
            or $v0, $t0, $zero
            jr $ra

/*
void inverse_chaine(char *ptr, uint32_t taille)
{
    char tmp;
    int32_t dep = taille - 1;
    while (dep > 0) {
        tmp = *ptr;
        *ptr = ptr[dep];
        ptr[dep] = tmp;
        dep = dep - 2;
        ptr++;
    }
}
*/
    .globl inverse_chaine
/*void inverse_chaine(char *ptr, uint32_t taille) */
/* Contexte fourni :
* Fonction feuille pas de modif de pile à faire
* ptr : registre $a0, paramètre de type (char *)
* taille : registre $a1, paramètre de type (uint32_t)
* tmp : registre $t0, variable locale de type (char)
* dep : registre $t1, variable locale de type (int32_t)
*/
inverse_chaine:
    /* char tmp; */
    lui $t0, 0
    /* int32_t dep = taille - 1; */
    and $t2, $t2, $zero
    addi $t2, $a1, -1
    or $t1, $t2, $zero
/* while (dep > 0){ */
while2 :
        ble $t1, $zero, fin_while2
        /* tmp = *ptr; */
        lbu $t0, 0($a0)
        /* *ptr = ptr[dep]; */
        addu $t4, $a0, $t1 /* $t4 : &ptr[dep] */
        lbu $t5, 0($t4) /* $t5 : ptr[dep] */
        sb $t5, 0($a0)
        /* ptr[dep] = tmp; */
        sb $t0, 0($t4)
        /* dep = dep - 2; */
        addi $t1, $t1, -2
        /* ptr++; */
        addiu $a0, $a0, 1
        /* } */
        j while2
fin_while2 :
            jr $ra
