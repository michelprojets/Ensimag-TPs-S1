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
  sp+0 : place pour x ($a0 de mult)
  sp+4 : place pour a ($a1 de mult)
  sp+8 : place pour $ra

  (on pouvait juste sauvegarder une place pour a car on réutilise que b)
*/

affine:
/* A compléter */
    /* on reserve la place nécessaire dans la pile */
    addiu $sp,$sp,-3*4
    /* on y sauvegarde l'adresse de retour */
    sw $ra, 2*4($sp)
    /* sauvegarde de a et b ()*/
    sw $a1, 0*4($sp)
    sw $a0, 1*4($sp)
    /* on place les bons $a0 et $a1 pour mult */
    /* utiliser une var temporaire */
    move $a0, $a2
    move $a1, $a0
      /* return mult(x,a)+b; */
      jal mult
      /* on remet les valeurs initiales de a et b */
      lw $a1, 0*4($sp)
      lw $a0, 1*4($sp)
      addu $v0, $v0, $a1
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
