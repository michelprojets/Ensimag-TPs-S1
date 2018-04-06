/*
void inverse(struct cellule_t **l)
{
   struct cellule_t *res, *suiv;
   res = NULL;
   while (*l != NULL) {
       suiv = (*l)->suiv;
       (*l)->suiv = res;
       res = *l;
       *l = suiv;
   }
   *l = res;
}
*/
    .text
    .globl inverse

/* void inverse(struct cellule_t **l) */
/* Contexte :
  Fonction feuille (pas de modif de pile à faire)
  place param : np=0
  place pour variables locales : nv=0
  place registre ra : nr=0
  => N=0*4 donc pile +0*4
  res : registre $t0, param de type (cellule_t *)
  suiv : registre $t1, param de type (cellule_t *)
  $a0 contient l'adresse de l'adresse de la premiere cellule de la liste l
  (sauvegarde possible à SP+0)
*/
inverse:
    /* struct cellule_t *res, *suiv; */
    lui $t0, 0
    lui $t1, 0
    /* res = NULL; */
    lui $t0, 0

while :
    /* while (*l != NULL) { */
    lw $t2, 0($a0) /* $t2 : *l : adresse d'une cellule de la liste l */
    beq $t2, $zero, fin_while
    /* suiv = (*l)->suiv; */
    lw $t3, 4($t2) /* $t3 : (*l)->suiv : adresse de la cellule suivante */
                   /* 4 car deuxième élément de la struct */
    or $t1, $t3, $zero
    /* (*l)->suiv = res; */
    sw $t0, 4($t2)  /* on réutilise $t2 car c'est un pointeur */
                    /* 4 car deuxième élément de la struct */
    /* res = *l; */
    or $t0, $t2, $zero /* on réutilise $t2 car c'est un pointeur */
    /* *l = suiv; */
    sw $t1, 0($a0)
    j while

fin_while :
    /* *l = res; */
    sw $t0, 0($a0)
    jr $ra

/*
struct cellule_t *decoupe(struct cellule_t *l, struct cellule_t **l1, struct cellule_t **l2)
{
    struct cellule_t fictif1, fictif2;
    *l1 = &fictif1;
    *l2 = &fictif2;
    while (l != NULL) {
        if (l->val % 2 == 1) {
            (*l1)->suiv = l;
            *l1 = l;
        } else {
            (*l2)->suiv = l;
            *l2 = l;
        }
        l = l->suiv;
    }
    (*l1)->suiv = NULL;
    (*l2)->suiv = NULL;
    *l1 = fictif1.suiv;
    *l2 = fictif2.suiv;
    return l;
}
*/
    .globl decoupe
/* Contexte :
Fonction feuille : A priori pile inchangée, mais besoin de l'adresse des
variables locales => implantation des variables locales en pile.
Besoin de 2*2 mots de 32 bits dans la pile (PILE+16)

place pour variables locales : nv=2*2*4=4*4
=> N=4*4 donc pile +4*4

l  : registre $a0, paramètre de type (struct cellule_t *)
l1 : registre $a1, paramètre de type (struct cellule_t **)
l2 : registre $a2, paramètre de type (struct cellule_t **)
fictif1 : PILE à SP, variable locale de type struct cellule_t,
    champ val de type int32_t à SP,
    champ suiv de type (struct cellule_t *) à SP+4
fictif2 : PILE à SP, variable locale de type struct cellule_t,
    champ val de type int32_t à SP+8,
    champ suiv de type (struct cellule_t *) à SP+12
*/
decoupe:
    jr $ra
