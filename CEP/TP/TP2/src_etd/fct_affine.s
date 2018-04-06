/*
uint32_t affine(uint32_t a,uint32_t b,uint32_t x)
{
   return mult(x,a)+b;
}
*/

    .text
    .globl affine
    /* uint32_t affine(uint32_t a,uint32_t b,uint32_t x) */

/* Contexte:
	A compléter

  place paramètres : np=2
  place pour variables locales
  place registre ra : nr=1
  => N=3*4 donc pile +3*4
  PILE:
  sp+0 : place pour a ($a1) de mult
  sp+4 : place pour x ($a0) de mult
  sp+8 : place pour $ra

  (on pouvait juste sauvegarder une place pour a car on réutilise que b)
*/

affine:
/* A compléter */
    /* on reserve la place nécessaire dans la pile */
    addiu $sp,$sp,-3*4
    /* on y sauvegarde l'adresse de retour */
    sw $ra, 2*4($sp)
    /* on place les bons $a0 et $a1 pour mult */
    /* on fait en sorte que a0 contienne x, a1 contienne a et a2 contienne b */
    move $t0, $a0 /* variable temporaire */
    move $a0, $a2
    move $a2, $a1
    move $a1, $t0

    /* ON AURAIT PU JUSTE SAUVEGARDER LES 3 PARAMETRES DANS LEUR PLACE ALLOUEE PAR LA FONCTION
    APPELANTE PUIS PLACER x ET a POUR LE PROCHAIN APPEL DE FONCTION AVEC DES sw AU LIEU
    D'UTILISER DES VARIABLES TEMPORAIRES ETC. !!!!! */

    /* sauvegarde de x ($a0) et a ($a1) dans la place allouée par la fonction appelante */
    sw $a0, 3*4($sp)
    sw $a1, 5*4($sp)
      /* return mult(x,a)+b; */
      jal mult
      /* on remet les valeurs initiales de b et a */
      lw $a0, 3*4($sp)
      lw $a1, 5*4($sp)
      /* ici, a0 contient x, a1 contient a et a2 contient b */
      addu $v0, $v0, $a2
    /* on récupère l'adresse de retour' */
    lw $ra, 2*4($sp)
    /* on replace le pointeur de pile */
    addiu $sp,$sp,3*4
    /* on retourne à l'instruction suivante du programme appelant */
    jr $ra


/* uint32_t mult(uint32_t x,uint32_t y) { return x*y;} */
	/* Contexte :
	Convention
	x : $a0
	y : $a1
	valeur temporaire res  :$t0
	retour dans $v0 */
mult:
    /* res = 0 */
    or $t0,$zero,$zero
    /* while (y != 0) */
while:
    beq $a1, $zero, fin_while
    /* res = res + x */
    addu $t0, $a0, $t0
    /* y-- */
    addiu $a1,$a1, -1
    /* } */
    j while
fin_while:
    /* return res; */
    or $v0,$t0,$zero
    jr $ra
