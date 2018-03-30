/*
void tri_min(int32_t tab[], uint32_t taille)
{
    uint32_t i, j, ix_min;
    int32_t tmp;
    for (i = 0; i < taille - 1; i++) {
        for (ix_min = i, j = i + 1; j < taille; j++) {
            if (tab[j] < tab[ix_min]) {
                ix_min = j;
            }
        }
        tmp = tab[i];
        tab[i] = tab[ix_min];
        tab[ix_min] = tmp;
    }
}
*/
    .text
    .globl tri_min
/* void tri_min(int32_t tab[], uint32_t taille) */
/* Contexte : à définir
   Fonction feuille (pas de modif de pile à faire)
   place param : np=0
   place pour variables locales : nv=0
   place registre ra : nr=0
   => N=0*4 donc pile +0*4
   tab : registre $a0, param de type (int32_t *)
   taille : registre $a1, param de type (uint32_t)
   i : registre $t0, var locale de type (uint32_t)
   j : registre $t1, var locale de type (uint32_t)
   ix_min : registre $t2, var locale de type (uint32_t)
   tmp : registre $t3, var locale de type (int32_t)
*/
tri_min:
    /* uint32_t i, j, ix_min; */
    lui $t0, 0
    lui $t1, 0
    lui $t2, 0
    /* int32_t tmp; */
    li $t3, 0
    /* for (i = 0; */
for1 :
      and $t0, $t0, $zero
      /* i < taille - 1; */
      addi $t4, $a1, -1
      bge $t0, $t4, fin_for1

      /* for (ix_min = i, j = i + 1; */
for2 :
      and $t2, $t2, $zero
      or $t2, $t2, $t0
      addu $t1, $t0, 1
      /* j < taille; */
      bge $t1, $a1, fin_for2
      /* j++) */
      addu $t1, $t1, 1
      /* if (tab[j] < tab[ix_min]) { */
      addu $t5, $a0, $t1
      lui $t6, 4 /* uint32_t fait 4 octets */
      mult $t5, $t6 /* $t5 : &tab[j] */
      ld $t7, 0($t5) /* t7 : tab[j] */
      addu $t5, $a0, $t2
      lui $t6, 4 /* uint32_t fait 4 octets */
      mult $t5, $t6 /* $t5 : &tab[ix_min] */
      ld $t8, 0($t5) /* t8 : tab[ix_min] */
      bge $t7, $t8, fin_si
      /* ix_min = j; */
      or $t2, $t1, $zero
fin_si :
      /* } */
      j for2

fin_for2 :
          /* tmp = tab[i]; */
          addu $t5, $a0, $t0
          lui $t6, 4 /* uint32_t fait 4 octets */
          mult $t5, $t6 /* $t5 : &tab[i] */
          ld $t3, 0($t5)
          /* tab[i] = tab[ix_min]; */
          addu $t5, $a0, $t2
          lui $t6, 4 /* uint32_t fait 4 octets */
          mult $t5, $t6 /* $t5 : &tab[ix_min] */
          ld $t7, 0($t5) /* t7 : tab[ix_min] */
          addu $t8, $a0, $t0
          lui $t6, 4 /* uint32_t fait 4 octets */
          mult $t8, $t6 /* $t8 : &tab[i] */
          sw $t7, 0($t8)
          /* tab[ix_min] = tmp; */
          addu $t5, $a0, $t2
          lui $t6, 4 /* uint32_t fait 4 octets */
          mult $t5, $t6 /* $t5 : &tab[ix_min] */
          sw $t3, 0($t5)
          /* i++) */
          addu $t0, $t0, 1
          /* } */
          j for1

fin_for1 :
          jr $ra
