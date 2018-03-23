/*
void hello(void)
{
	affiche_HelloWorld();
}
*/

    .text
    .globl hello
    /* void hello(void) */

/* Contexte :
	Fonction non feuille.
	Pas de paramètre, Pas de variable locale.
	$ra doit être sauvegardé dans la pile pour ne pas être écrasé lors de l appel de fonction
	$ra à l entree dans la fonction : pile à SP+0

  pas de place pour paramètres
  pas de place pour variable locale car fonction feuille
  place registre ra : nr=1
  => N=1*4 donc pile +1*4
  PILE:
  sp+0 : place pour $ra
*/

hello:
    /* on reserve la place nécessaire dans la pile */
    addiu $sp,$sp,-1*4
    /* On y sauvegarde l'adresse de retour */
    sw $ra, 0($sp)
    /* affiche_HelloWorld(); */
    jal affiche_HelloWorld
    /* On récupère l'adresse de retour */
    lw $ra, 0($sp)
    /* on replace le pointeur de pile */
    addiu $sp,$sp,1*4
    /* on retourne à l'instruction suivante du programme appelant */
    jr $ra
