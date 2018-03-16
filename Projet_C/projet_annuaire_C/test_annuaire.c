#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>
#include <ctype.h>
#include <stdio.h>

#include "annuaire.h"

// pour nos tests
#define NB_CARAC_MAX 10
#define NB_TESTS 9
#define POURCENTAGE 100.0
#define MOITIE 2

/**
 *@brief Fonction d'affichage de l'annuaire pour le debogage
 *@param[in] an : l'annuaire'
 *@pre an != NULL
 */
void afficher_annuaire(const struct annuaire * an){
    // preconditions
    assert(an != NULL);

    uint8_t taux_remplissage = (uint8_t)(((float)(an->nb_cases_non_vides)/
                                          (float)(an->nb_cases))*POURCENTAGE);
    printf("\n----- annuaire -----\n");
    printf("Taille de la table de hachage : %u\n", an->nb_cases);
    printf("Nombre de cases occupees : %u\n", an->nb_cases_non_vides);
    printf("Taux de remplissage : %u %%\n", taux_remplissage);
    printf("-----\n");
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

    // on pouvait aussi utiliser un tableau de char *
    char noms[][NB_CARAC_MAX + 1] = {"paul", "jacques", "christophe",
                                     "alain", "patrick", "sylvain",
                                     "baptiste", "carl", "tony"};
    char numeros[][NB_CARAC_MAX + 1] = {"0654659842", "0665156429", "0654625465",
                                        "0602321545", "0640980212", "0664314897",
                                        "0625161432", "0656454631", "0642342345"};
    // insertion des noms et des numeros dans l'annuaire
    char * ancien_num = NULL;
    for (uint8_t i=0; i<NB_TESTS; ++i){
        ancien_num = inserer(an, noms[i], numeros[i]);
        assert(ancien_num == NULL);
    }
    // affichage de l'annuaire (pour le debogage)
    printf("\n<<<<<<<<<< Apres insertion >>>>>>>>>>\n");
    afficher_annuaire(an);

    char * nom_doublon = calloc(strlen(noms[0]) + 1, sizeof(char));
    strcpy(nom_doublon, noms[0]); // "paul"
    char * num_doublon = calloc(strlen(numeros[0]) + 1, sizeof(char));
    strcpy(num_doublon, "0611111111");
    // insertion d'un nom deja existant
    ancien_num = inserer(an, nom_doublon, num_doublon);
    assert(ancien_num != NULL);
    assert(strcmp(ancien_num, numeros[0]) == 0);
    // post-condition : liberation en memoire de l'ancien numero
    free(ancien_num);
    // affichage de l'annuaire (pour le debogage)
    printf("\n<<<<<<<<<< Apres insertion doublon >>>>>>>>>>\n");
    afficher_annuaire(an);

    // synchronisation avec le tableau de tests (apres l'insertion d'une entree deja existante)
    strcpy(numeros[0], num_doublon);

    // liberation en memoire des doublons caracteres (car besoin juste pour la duree de l'insertion)
    free(nom_doublon);
    free(num_doublon);

    // recherche de numeros associes a des noms existants dans l'annuaires
    const char * num_recherche = NULL;  // const empeche la modification de la valeur pointée par le pointeur
                                        // (et non du pointeur)
    for (uint32_t i=0; i<NB_TESTS; ++i){
        num_recherche = rechercher_numero(an, noms[i]);
        assert(strcmp(num_recherche, numeros[i]) == 0);
        // post-condition : liberation en memoire de la copie du numero
        free((void *)num_recherche);  // free ne prend pas de const car free libere la zone memoire pointee par le pointeur
    }

    // suppression d'entrees nom/numero (la moitie)
    for (uint32_t i=0; i<(NB_TESTS/MOITIE)+1 ; ++i){
        supprimer(an, noms[i]);
        assert(rechercher_numero(an, noms[i]) == NULL);
    }
    // on test une suppression d'une entree inexistante dans l'annuaire (ne fait rien)
    supprimer(an, noms[0]);
    // affichage de l'annuaire (pour le debogage)
    printf("\n<<<<<<<<<< Apres suppression >>>>>>>>>>\n");
    afficher_annuaire(an);

    // liberation en memoire de toutes les entrees de l'annuaire et l'annuaire lui-meme
    liberer(an);

    return EXIT_SUCCESS;

}
