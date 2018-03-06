#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "annuaire.h"

struct annuaire * creer(){
    struct annuaire * an = (annuaire *)calloc(NB_CASES_TAB,
                                              sizeof(struct cellule));
    return an;
}

/**
 *@brief Calcule la valeur de hachage associee a une cle (nom de la personne)
 *@param[in] nom : le nom de la personne
 *@return la valeur de hachage associee a la cle (nom de la personne)
 *@pre nom != ""
 */
u_int32_t hachage(const char * nom){
    // preconditions
    assert(nom != NULL);
    assert(strcmp(nom, "") != 0);

    u_int32_t pos = 0;
    u_int32_t hash = 5381;
    char carac = nom[0];
    while (carac != '\0'){
        hash = hash * 33 + carac;
        pos++;
        carac = nom[pos];
    }
    return hash;
}

char * inserer(struct annuaire * an, const char * nom, const char * numero){
    // preconditions
    assert(an != NULL);
    assert(nom != NULL);
    assert(numero != NULL);
    assert(strcmp(nom, "") != 0);
    assert(strcmp(numero, "") != 0);

    bool trouve = false;
    u_int32_t index = hachage(nom)%NB_CASES_TAB;
    struct cellule * courant = (an->table)[index];
    if (courant->nom == NULL){  // liste vide
        char * copy_nom;
        char * copy_num;
        strcpy(copy_nom, nom);
        strcpy(copy_num, numero);
        courant->nom = copy_nom;
        courant->numero = copy_num;
    }
    while (courant != NULL){
        if (strcmp(courant->nom, nom) == 0){  // on trouve le nom
            trouve = true;
        }
        courant = courant->suiv;
    }
    if (trouve == true){  // si on a trouve un nom deja existant
        char * copy_nom;
        char * copy_num;
        strcpy(copy_nom, nom);
        strcpy(copy_num, numero);
        struct cellule nouvelle = {copy_nom, copy_num, NULL};
        courant->suiv = (cellule *)malloc(sizeof(struct cellule));
        courant->suiv = &nouvelle;
    }

    return NULL;
}

char * rechercher_numero(struct annuaire * an, const char * nom){
    // preconditions
    assert(an != NULL);
    assert(nom != NULL);
    assert(strcmp(nom, "") != 0);

    return NULL;
}

void supprimer(struct annuaire * an, const char * nom){
    // preconditions
    assert(an != NULL);
    assert(nom != NULL);
    assert(strcmp(nom, "") != 0);

    return;
}

void liberer(struct annuaire * an){
    // preconditions
    assert(an != NULL);

    return;
}
