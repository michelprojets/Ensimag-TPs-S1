/* L'enonce de l'exercice se trouve dans le fichier test_tableau.c.  */

/* Utilisation du preprocesseur C pour se proteger de l'inclusion multiple */
#ifndef _TABLEAU_H_
#define _TABLEAU_H_

#include <stdint.h>

#define MAX 50;

/* Affiche les taille elements du tableau tab. */
extern void affiche(int32_t tab[], uint32_t taille);

/* Initialise les taille elements du tableau tab par des valeurs
 * entieres entrees au clavier par l'utilisateur. */
extern void init_interactive(int32_t tab[], uint32_t taille);

/* Initialise les taille elements du tableau tab par des valeurs
 * entieres tirees aleatoirement. */
extern void init_aleatoire(int32_t tab[], uint32_t taille);

/* Trie le tableau tab a l'aide de l'algorithme de tri par
 * insertion. */
extern void tri_insertion(int32_t tab[], uint32_t taille);

#endif /* _TABLEAU_H_ */
