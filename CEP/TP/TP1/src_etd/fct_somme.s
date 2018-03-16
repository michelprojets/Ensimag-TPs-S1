/*
uint8_t res8;
uint32_t res;

uint32_t somme(void)
{
    uint32_t i;
    uint32_t res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}

uint32_t sommeMem(void)
{
    uint32_t i;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}

uint8_t somme8(void)
{
    uint8_t i;
    res8 = 0;
    for (i = 1; i <= 24; i++) {
        res8 = res8 + i;
    }
    return res8;
}
*/
    .text
    .globl somme
/*
  CONTEXTE:
  i : $t0
  res : $t1
  retour : $v0
*/
somme:
    /* uint32_t i; */
    and $t0, $t0, $zero
    /* uint32_t res = 0; */
    and $t1, $t0, $zero
    /* for (i = 1; */
    addiu $t0, $t0, 0x0001
for:
    /* i <= 10; */
    ori $t2, $t2, 0x000A
    subu $t3, $t0, $t2
    bgtz $t3, fin_for
    /* res = res + i; */
    addu $t1, $t1, $t0
    /* i++) { */
    addiu $t0, $t0, 0x0001
    /* } */
    j for
fin_for:
    /* return res; */
    or $v0, $t1, $zero
    /* on clean tous les registres utilises avant de revenir */
    and $t0, $t0, $zero
    and $t1, $t0, $zero
    and $t2, $t0, $zero
    and $t3, $t0, $zero
    jr $ra

    .globl sommeMem
/*
  CONTEXTE:
  i : $t0
  retour : $v0
*/
/*
  a faire a chaque fois dans le cas des tps
  lw $t1, res
  modif de $t1
  sw $zero, res

  sb / lb : store 8 / load 8
*/
sommeMem:
    /* on clean le registre de retour $v0
    and $v0, $v0, $zero
    /* on clean le registre de retour $v0
    and $v0, $v0, $zero
    /* uint32_t i; */
    and $t0, $t0, $zero
    /* uint32_t res = 0; */
    lw $t0, res
    /* for (i = 1; */
    addiu $t0, $t0, 0x0001
for2:
    /* i <= 10; */
    ori $t2, $t2, 0x000A
    subu $t3, $t0, $t2
    bgtz $t3, fin_for2
    /* res = res + i; */
    addu $t1, $t1, $t0
    /* i++) { */
    addiu $t0, $t0, 0x0001
    /* } */
    j for
fin_for2:
    /* return res; */
    or $v0, $t1, $zero
    jr $ra

    .globl somme8
somme8:
/*  Contexte : à préciser */

    .data
/* uint32_t res;
 la variable globale res étant définie dans ce fichier, il est nécessaire de
 la définir dans la section .data du programme assembleur : par exemple, avec
 la directive .comm vu qu'elle n'est pas initialisée (idem pour res8)
*/
