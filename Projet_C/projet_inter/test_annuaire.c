#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>
#include <ctype.h>
#include <stdio.h>

#include "annuaire.h"

#define NB_CARAC_MAX 10
#define NB_TESTS 9

/* fonction d'affichage d'un annuaire pour le debogage */
void afficher_annuaire(struct annuaire * an){
    printf("\n----- annuaire -----\n");
    for (uint8_t i=0; i<NB_CASES_TAB; ++i){
        struct cellule * courant = (an->table)[i];
        if (courant->nom == NULL){  // liste vide
            printf("{}\n");
        }
        else if (courant->suiv == NULL){ // liste a un element
            printf("{%s, %s}\n", courant->nom, courant->numero);
        }
        else{ // liste a plusieurs elements
            printf("{%s, %s}", courant->nom, courant->numero);
            while (courant->suiv != NULL){
                printf(", ");
                courant = courant->suiv;
                printf("{%s, %s}", courant->nom, courant->numero);
            }
            printf("\n");
        }
    }
    printf("---- fin annuaire ----\n\n");
}

/* programme principal (avec tests) */
int main(){

    // creation d'un annuaire vide
    struct annuaire * an = creer();

    char noms[][NB_CARAC_MAX + 1] = {"paul", "jacques", "christophe",
                                     "alain", "patrick", "sylvain",
                                     "baptiste", "carl", "tony"};
    char numeros[][NB_CARAC_MAX + 1] = {"0654659842", "0665156429", "0654625465",
                                        "0602321545", "0640980212", "0664314897",
                                        "0625161432", "0656454631", "0642342345"};
    // insertion des noms et des numeros dans l'annuaire
    for (uint8_t i=0; i<NB_TESTS; ++i){
        // printf("(%s)(%s)\n", noms[i], numeros[i]);
        inserer(an, noms[i], numeros[i]);
    }
    // affichage de l'annuaire (pour le debogage)
    printf("\n////////// Apres insertion //////////\n");
    afficher_annuaire(an);

    char * nom_doublon = calloc(strlen(noms[0]) + 1, sizeof(char));
    strcpy(nom_doublon, noms[0]); // "paul"
    char * num_doublon = calloc(strlen(numeros[0]) + 1, sizeof(char));
    num_doublon = "0611111111";
    // insertion d'un nom deja existant
    char * ancien_num = inserer(an, nom_doublon, num_doublon);
    assert(ancien_num != NULL);
    assert(strcmp(ancien_num, numeros[0]) == 0);
    // post-condition : liberation en memoire de l'ancien numero
    free(ancien_num);
    ancien_num = NULL;
    // affichage de l'annuaire (pour le debogage)
    printf("\n////////// Apres insertion doublon //////////\n");
    afficher_annuaire(an);

    // synchronisation avec le tableau de tests (apres l'insertion d'une entree deja existante)
    strcpy(numeros[0], num_doublon);

    // recherche de numeros associes a des noms existants dans l'annuaires
    for (uint32_t i=0; i<NB_TESTS; ++i){
        assert(strcmp(rechercher_numero(an, noms[i]), numeros[i]) == 0);
    }

    // // suppression d'entrees nom/numero (la moitie)
    // for (uint32_t i=0; i<NB_TESTS/2; ++i){
    //     supprimer(an, noms[i]);
    //     assert(rechercher_numero(an, noms[i]) == NULL);
    // }
    // // affichage de l'annuaire (pour le debogage)
    // printf("\n////////// Apres suppression //////////\n");
    // afficher_annuaire(an);

    // liberation en memoire de toutes les entrees de l'annuaire et l'annuaire lui-meme
    liberer(an);

    return EXIT_SUCCESS;

}
