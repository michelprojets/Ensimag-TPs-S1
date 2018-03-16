#ifndef _ANNUAIRE_H_
#define _ANNUAIRE_H_

#include <stdint.h>
#include <stdbool.h>

#define NB_CASES_TAB 10 // nombre de cases initial dans la table de hachage

struct cellule{ // une liste chainee
    char * nom; // chaine de caracteres representant le nom de la personne
    char * numero; // chaine de caracteres representant le numero de telephone de la personne
    struct cellule * suiv; // entree (nom/numero) suivante
};

struct annuaire{  // un annuaire
    uint8_t nb_cases; // nombre de cases dans la table de hachage
    uint8_t nb_cases_non_vides; // nombre de listes non vides dans la table de hachage
    bool maj_en_cours;  // indique si la table est en plein redimentionnement ou pas
    struct cellule * table[NB_CASES_TAB]; // tableau de listes chainees
};

/**
 *@brief Creation d'un annuaire initialement vide
 */
extern struct annuaire * creer();

/**
 *@brief Insere une nouvelle entree nom/numero dans l'annuaire
 *@param[in] nom : le nom de la personne
 *@param[in] numero : le numero de telephone
 *@param[in,out] an : l'annuaire
 *@return NULL si l'annuaire ne contenait pas le nom, l'ancien numero correspondant au nom sinon
 *@pre an != NULL && nom != "" && numero != ""
 *@pos la chaine retournee doit etre liberee en memoire
 */
extern char * inserer(struct annuaire * an, const char * nom, const char * numero);

/**
 *@brief Recherche dans l'annuaire le numero de telephone associe au nom de la personne
 *@param[in] nom : le nom de la personne
 *@param[in,out] an : l'annuaire
 *@return une copie du numero de telephone associe au nom de la personne
 *@pre an != NULL && nom != ""
 *@pos la chaine retournee doit etre liberee en memoire
 */
extern const char * rechercher_numero(struct annuaire * an, const char * nom);

/**
 *@brief Supprime l'entree nom/numero associee au nom, si le nom n'existe pas, ne fait rien
 *@param[in] nom : le nom de la personne
 *@param[in,out] an : l'annuaire
 *@pre an != NULL && nom != ""
 */
extern void supprimer(struct annuaire * an, const char * nom);

/**
 *@brief Supprime/libere toutes les entrees de l'annuaire et l'annuaire lui-meme
 *@param[in,out] an : l'annuaire
 *@pre an != NULL
 */
extern void liberer(struct annuaire * an);


#endif  /* _ANNUAIRE_H_ */