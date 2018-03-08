#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "annuaire.h"

#define NB_CARAC_MAX 10
#define NB_TESTS 9

/* programme principal (avec tests) */
int main(int argc, char *argv[]){

    // creation d'un annuaire vide
    struct annuaire * an = creer();

    char noms[][NB_CARAC_MAX + 1] = {"paul", "jacques", "christophe",
                                     "alain", "patrick", "sylvain",
                                     "baptiste", "carl", "tony"};
    char numeros[][NB_CARAC_MAX + 1] = {"0654659842", "0665156429", "0654625465",
                                        "0602321545", "0640980212", "0664314897",
                                        "0625161432", "0656454631", "0642342345"};
    // insertion des noms et des numeros dans l'annuaire
    for (u_int8_t i=0; i<NB_TESTS; ++i){
        inserer(an, noms[i], numeros[i]);
    }

    char * nom_doublon = NULL;
    strcpy(nom_doublon, noms[0]); // "paul"
    char num_doublon[] = {"0611111111"};
    // insertion d'un nom deja existant
    char * ancien_num = inserer(an, nom_doublon, num_doublon);
    assert(ancien_num != NULL);
    assert(strcmp(ancien_num, numeros[0]) == 0);
    // post-condition : liberation en memoire de l'ancien numero
    free(ancien_num);
    ancien_num = NULL;

    // synchronisation avec le tableau de tests (apres l'insertion d'une entree deja existante)
    for (u_int32_t i=0; i< NB_CARAC_MAX; ++i){
        numeros[0][i] = ancien_num[i];
    }

    // recherche de numeros associes a des noms existants dans l'annuaires
    for (u_int32_t i=0; i<NB_TESTS; ++i){
        assert(strcmp(rechercher_numero(an, noms[i]), numeros[i]) == 0);
    }

    // suppression d'entrees nom/numero (la moitie)
    for (u_int32_t i=0; i<NB_TESTS/2; ++i){
        supprimer(an, noms[i]);
        assert(rechercher_numero(an, noms[i]) == NULL);
    }

    // liberation en memoire de toutes les entrees de l'annuaire et l'annuaire lui-meme
    liberer(an);
    assert(an == NULL);

    return EXIT_SUCCESS;

}
