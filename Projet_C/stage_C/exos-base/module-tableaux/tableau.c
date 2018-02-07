/* L'enonce de l'exercice se trouve dans le fichier test_tableau.c.  */
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>

#include "tableau.h"

void affiche(int32_t tab[], uint32_t taille){
    printf("Tableau de taille %u\n", taille);
    printf("[");
    for (uint32_t i=0; i<taille; ++i){
        printf("%i", tab[i]);
        if (i != taille-1){
            printf(", ");
        }
    }
    printf("]\n");
}

void init_interactive(int32_t tab[], uint32_t taille){
    int carac;
    int chiffre;
    int nombre;
    getc(stdin);  // pour récupérer le retour chariot précédent
    for (uint32_t i=0; i<taille; ++i){
        nombre = 0;
        carac = getc(stdin);
        while (carac != '\n'){
            if (carac < '0' || carac > '9'){
                exit(EXIT_FAILURE);
            }
            chiffre = carac - '0';
            nombre = 10 * nombre + chiffre;
            carac = getc(stdin);
        }
        tab[i] = nombre;
    }
}

void init_aleatoire(int32_t tab[], uint32_t taille){
    srand(time(NULL));
    for (uint32_t i=0; i<taille; ++i){
        tab[i] = rand()%MAX;
    }
}

void tri_insertion(int32_t tab[], uint32_t taille){
    int save;
    for (uint32_t i=1; i<taille; ++i){
        for (uint32_t j=0; j<i; ++j){
            if (tab[i] < tab[j]){
                save = tab[i];
                // décalage pour insertion
                for (uint32_t k=i; k>j; --k){
                    tab[k] = tab[k-1];
                }
                tab[j] = save;
            }
        }
    }
}

// /* autre maniere plus optimale pour le tri par insertion */
// /* -> décalage en même temps que le parcours !!!!!!!!!!! */
// void tri_insertion(int32_t tab[], uint32_t taille){
//     /* A implémenter! */
//     /*
//         Si taille <= 1, le tableau est deja trié.
//         Sinon, on parcourt du 2eme au dernier élément.
//     */
//
//     for (uint32_t i = 1; i < taille; i++) {
//         /*
//             invariant : tab trié de 0 à i-1
//         */
//         int32_t tmp = tab[i]; // valeur à insérer
//         /*
//             Parcours du tableau dans l'ordre décroissant avec l'indice j.
//             j est déclaré signé pour pouvoir comparer sa valeur à 0.
//         */
//         int32_t j = i - 1;
//         while (j >= 0 && tab[j] > tmp) {
//             tab[j+1] = tab[j]; // décalage de la case du tableau testée
//             j--;
//         }
//         /*
//             On sort du parcours à la position d'insertion pour la valeur tmp.
//             Couvre le cas encadrement trouvé entre les indices j et j+1 et
//             aussi le cas pas d'encadrement trouvé (j == -1). Dans les 2 cas, il
//             faut mettre tmp dans la case j+1.
//         */
//         tab[j+1] = tmp;
//     }
// }
