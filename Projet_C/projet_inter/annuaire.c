#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>

#include "annuaire.h"

struct annuaire * creer(){
    struct annuaire * an = (struct annuaire *)malloc(sizeof(struct annuaire));
    an->nb_cases = NB_CASES_TAB;
    an->nb_cases_vides = an->nb_cases;
    for (uint8_t i = 0; i<an->nb_cases; ++i){
        an->table[i] = (struct cellule *)malloc(sizeof(struct cellule));
        an->table[i]->nom = NULL;
        an->table[i]->numero = NULL;
        an->table[i]->suiv = NULL;
    }
    return an;
}

/**
 *@brief Calcule la valeur de hachage associee a une cle (nom de la personne)
 *@param[in] nom : le nom de la personne
 *@return la valeur de hachage associee a la cle (nom de la personne)
 *@pre nom != ""
 */
uint32_t hachage(const char * nom){
    // preconditions
    assert(nom != NULL);
    assert(strcmp(nom, "") != 0);

    uint32_t pos = 0;
    uint32_t hash = 5381;
    char carac = nom[0];
    while (carac != '\0'){
        hash = hash * 33 + carac;
        pos++;
        carac = nom[pos];
    }
    return hash;
}

/**
 *@brief Redimensionne l'annuaire si necessaire
 *@param[in] nom : l'annuaire'
 *@pre an != NULL
 */
 void maj_annuaire(struct annuaire * an){
    // preconditions
    assert(an != NULL);

    float taux_remplissage = 0.0;
    taux_remplissage = (an->nb_cases_vides)/(an->nb_cases);
    // dans le cas ou on doit redimentionner la table
    if ((taux_remplissage <= (float)REMPLISSAGE_MIN) ||
        (taux_remplissage >= (float)REMPLISSAGE_MAX)){
        uint8_t nouveau_nb_elems = 0;
        if (taux_remplissage <= (float)REMPLISSAGE_MIN){  // table trop creuse
            nouveau_nb_elems = (an->nb_cases)/2;  // on reduit de moitier la taille de la table
            if (nouveau_nb_elems < NB_CASES_TAB){ // la taille de la table ne descend pas en dessous de 10
                nouveau_nb_elems = NB_CASES_TAB;
            }
        }
        else if (taux_remplissage >= (float)REMPLISSAGE_MAX){ // table trop remplie
            nouveau_nb_elems = (an->nb_cases)*2;  // on double la taille de la table
        }
        // construction du nouvel annuaire
        struct annuaire * nouvel_an = (struct annuaire *)malloc(sizeof(struct annuaire));
        nouvel_an->nb_cases = nouveau_nb_elems;
        for (uint8_t i = 0; i<nouveau_nb_elems; ++i){
            nouvel_an->table[i] = (struct cellule *)malloc(sizeof(struct cellule));
            nouvel_an->table[i]->nom = NULL;
            nouvel_an->table[i]->numero = NULL;
            nouvel_an->table[i]->suiv = NULL;
        }
        // recopie de toutes les donnees de l'ancien annuaire vers le nouvel annuaire
        // et on libere en meme temps en memoire toutes les donnees de l'ancien annuaire
        struct cellule * courant = NULL;
        struct cellule * save_suiv = NULL;
        for(uint8_t i=0; i<an->nb_cases; ++i){
            courant = (an->table)[i];
            if (courant->nom == NULL){  // liste vide
                free(courant);
            }
            else{ // liste non vide
                // insertion dans le nouvel annuaire
                inserer(nouvel_an, courant->nom, courant->numero);
                save_suiv = courant->suiv;  // sauvegarde du suivant
                free(courant->nom);
                free(courant->numero);
                free(courant);
                courant = save_suiv;
                while (courant != NULL){  // liste a plus de deux elements
                    // insertion dans le nouvel annuaire
                    inserer(nouvel_an, courant->nom, courant->numero);
                    save_suiv = courant->suiv;
                    free(courant->nom);
                    free(courant->numero);
                    free(courant);
                    courant = save_suiv;
                }
            }
        }
        an->nb_cases = 0;
        free(an);
        // on pointe vers le nouvel annuaire
        an = nouvel_an;
    }
 }

char * inserer(struct annuaire * an, const char * nom, const char * numero){
    // preconditions
    assert(an != NULL);
    assert(nom != NULL);
    assert(numero != NULL);
    assert(strcmp(nom, "") != 0);
    assert(strcmp(numero, "") != 0);

    char * copy_nom = calloc(strlen(nom) + 1, sizeof(char));
    char * copy_num = calloc(strlen(numero) + 1, sizeof(char));
    strcpy(copy_nom, nom);
    strcpy(copy_num, numero);
    char * ancien_num = NULL;
    // valeur de l'index calculee par la fonction de hachage
    uint32_t index = hachage(nom)%NB_CASES_TAB;
    struct cellule * courant = (an->table)[index];
    // liste vide ou a un element
    if (courant->nom == NULL){  // liste vide
        courant->nom = copy_nom;
        courant->numero = copy_num;
        --(an->nb_cases_vides); // on a insere dans une case anciennement vide de la table
        return NULL;
    }
    else if (strcmp(courant->nom, nom) == 0){ // liste a un élement et on trouve le nom
        ancien_num = calloc(strlen(courant->numero) + 1, sizeof(char));
        ancien_num = courant->numero;
        courant->nom = copy_nom;
        courant->numero = copy_num;
        return ancien_num;
    }
    else{ // liste a plusieurs elements
        while (courant->suiv != NULL){
            if (strcmp(courant->nom, nom) == 0){  // on trouve le nom
                ancien_num = calloc(strlen(courant->numero) + 1, sizeof(char));
                ancien_num = courant->numero;
                courant->nom = copy_nom;
                courant->numero = copy_num;
                return ancien_num;
            }
            courant = courant->suiv;
        }
        // ici, on n'a pas trouve pas le nom
        courant->suiv = (struct cellule *)malloc(sizeof(struct cellule));
        courant->suiv->nom = copy_nom;
        courant->suiv->numero = copy_num;
        courant->suiv->suiv = NULL;
        return NULL;
    }
    // re-dimensionnement potentiel de l'annuaire
    maj_annuaire(an);
    return NULL;
}

const char * rechercher_numero(struct annuaire * an, const char * nom){
    // preconditions
    assert(an != NULL);
    assert(nom != NULL);
    assert(strcmp(nom, "") != 0);

    char * copy_num = NULL;
    // valeur de l'index calculee par la fonction de hachage
    uint32_t index = hachage(nom)%NB_CASES_TAB;
    struct cellule * courant = (an->table)[index];
    // liste vide ou a un element
    if (courant->nom == NULL){ // liste vide
        return NULL;
    }
    else if (strcmp(courant->nom, nom) == 0){  // liste a un élement et on trouve le nom
        copy_num = calloc(strlen(courant->numero) + 1, sizeof(char));
        strcpy(copy_num, courant->numero);
        return copy_num;
    }
    else{ // liste a plusieurs elements
        while (courant->suiv != NULL){
            if (strcmp(courant->nom, nom) == 0){  // on trouve le nom
                copy_num = calloc(strlen(courant->numero) + 1, sizeof(char));
                strcpy(copy_num, courant->numero);
                return copy_num;
            }
            courant = courant->suiv;
        }
        if (strcmp(courant->nom, nom) == 0){  // dernier element
            copy_num = calloc(strlen(courant->numero) + 1, sizeof(char));
            strcpy(copy_num, courant->numero);
            return copy_num;
        }
    }
    return NULL;
}

void supprimer(struct annuaire * an, const char * nom){
    // preconditions
    assert(an != NULL);
    assert(nom != NULL);
    assert(strcmp(nom, "") != 0);

    // valeur de l'index calculee par la fonction de hachage
    uint32_t index = hachage(nom)%NB_CASES_TAB;
    struct cellule * courant = (an->table)[index];
    // liste vide ou a un element
    if (courant->nom == NULL){
        if (courant->nom == NULL){  // liste vide
            return;
        }
        else if (strcmp(courant->nom, nom) == 0){  // liste a un élement et on trouve le nom
            courant->nom = NULL;
            courant->numero = NULL;
            free(courant->nom);
            free(courant->numero);
            ++(an->nb_cases_vides); // une case vide a ete creee suite a la suppression
        }
        return;
    }
    // liste a plusieurs elements
    bool premiere = false;  // true si c'est la premiere cellule qui est supprimee
    struct cellule sentinelle = {NULL, NULL, courant};
    courant = &sentinelle;
    while (courant->suiv != NULL){
        if (strcmp(courant->suiv->nom, nom) == 0){  // on trouve le nom
            if (courant->suiv == (an->table)[index]){ // si c'est la premiere cellule
                premiere = true;
            }
            struct cellule * save_suiv = courant->suiv->suiv;
            free(courant->suiv->nom);
            free(courant->suiv->numero);
            free(courant->suiv);
            courant->suiv = save_suiv;
            break;
        }
        courant = courant->suiv;
    }
    if (premiere){  // si c'est la premiere cellule qu'on a supprime
        (an->table)[index] = courant->suiv;
    }
    // re-dimensionnement potentiel de l'annuaire
    maj_annuaire(an);
}

void liberer(struct annuaire * an){
    // preconditions
    assert(an != NULL);

    struct cellule * courant = NULL;
    struct cellule * save_suiv = NULL;
    for(uint8_t i=0; i<an->nb_cases; ++i){
        courant = (an->table)[i];
        if (courant->nom == NULL){  // liste vide
            free(courant);
        }
        else{ // liste non vide
            save_suiv = courant->suiv;  // sauvegarde du suivant
            free(courant->nom);
            free(courant->numero);
            free(courant);
            courant = save_suiv;
            while (courant != NULL){  // liste a plus de deux elements
                save_suiv = courant->suiv;
                free(courant->nom);
                free(courant->numero);
                free(courant);
                courant = save_suiv;
            }
        }
    }
    an->nb_cases = 0;
    an->nb_cases_vides = 0;
    free(an);
    an = NULL;
}
