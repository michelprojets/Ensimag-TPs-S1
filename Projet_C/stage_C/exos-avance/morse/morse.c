/*
  Enonce :

  Cet exercice vous fera manipuler les notions de constantes, de
  portee de variables ainsi que des fonctions avancees de traitement
  de chaines de caracteres.

  Attention : cet exercice comporte des notions de base et des notions
  avancees.

  La liste des caracteres a prendre en compte est la suivante :
  - l'ensemble des lettres minuscules de a a z compris ;
  - l'ensemble des chiffres de 0 a 9 compris ;
  - le caractere espace ' '.

  La liste des codes Morse correspondants aux caracteres, les lettres
  dans l'ordre puis les chiffres dans l'ordre et enfin le caractere
  espace, est la suivante :


  ".-","-...","-.-.","-..",".","..-.","--.","....","..",
  ".---","-.-",".-..","--","-.","---",".--.","--.-",".-.",
  "...","-","..-","...-",".--","-..-","-.--","--..",".----",
  "..---","...--","....-",".....","-....","--...","---..","---.",
  "-----","//"


  Directives de codage :

  - Completez le fichier entete morse.h

  - La liste des caracteres sera stockee dans une constante globale
  texte_ref de type tableau de caracteres a une dimension, vous ferez
  en sorte que cette constante globale ne soit visible que dans
  morse.c ;

  - La liste des codes Morse sera stockee dans une constante globale
  morse_ref de type tableau de chaines de caracteres a 2 dimensions,
  vous ferez en sorte que cette constante globale ne soit visible que
  dans morse.c ;

  - Les fonctions avancees de traitement de chaines de caracteres
    pourront etre utilisees (longueur, copie, comparaison,...) ;

  - Les constantes globales tableaux texte_ref et morse_ref seront
    initialisees lors de leur declaration ;

  - La fonction avancee strtok pourra aussi etre utilisee dans
    affiche_texte pour decouper la chaine en Morse en sous chaines ;

  - La fonction affiche_morse pourra prendre en compte des caracteres
    majuscule ou minuscule ;

  - Un fichier test_morse.c est fourni pour illustrer le
    fonctionnement desire des fonctions de morse.c ;

  Competences : 19,23,43,44,45,66,72,73,74,77,79
  Difficulte : 3
*/

#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define NB_LETTRES_ALPHA 26
#define NB_CARAC 37
#define NB_CARAC_MAX_MORSE 5

static const char texte_ref[NB_CARAC + 1] = {"abcdefghijklmnopqrstuvwxyz0123456789 "}; // ou bien {'a', 'b', ..., ' '};
static const char morse_ref[NB_CARAC][NB_CARAC_MAX_MORSE + 1] = {".-","-...","-.-.","-..",".","..-.","--.","....","..",
                                                                 ".---","-.-",".-..","--","-.","---",".--.","--.-",".-.",
                                                                 "...","-","..-","...-",".--","-..-","-.--","--..",".----",
                                                                 "..---","...--","....-",".....","-....","--...","---..","---.",
                                                                 "-----","//"};
                                                                 // ou bien {",-", {"-..."}, ..., {"//"}};

void help(){
    for (unsigned int i=0; i<strlen(texte_ref); ++i){
        printf("%c -> %s\n", texte_ref[i], morse_ref[i]);
    }
}

void affiche_texte(char *morse){
    int indice;

    // ON FAIT UNE COPIE CAR ON A PASSE UNE CHAINE CONSTANTE EN PARAMETRE (ON A PAS UTILISE DE VARIABLE POINTEUR POUR STOCKER LA CHAINE),
    // DONC ON A PAS LE DROIT DE MODIFIER (CAR CONST IMPLICITE DANS LE PARAMETRE FORMEL : "const char * morse") D'OU LE "SEGMENTATION FAULT"
    char copy[strlen(morse)+1];
    strcpy(copy, morse);
    // "On the first call to strtok() the string to be parsed should be specified in str"
    char* token = strtok(copy, " ");

    // "If no more tokens are found, strtok() returns NULL"
    while(token != NULL){
        for (indice=0; indice < NB_CARAC; ++indice){
            if (strcmp(token, morse_ref[indice]) == 0){
                break;
            }
        }
        printf("%c", texte_ref[indice]);
        // "In each subsequent call that should parse the same string, str must be NULL"
        // "Each call to strtok() returns a pointer to a null-terminated string containing the next token"
        token = strtok(NULL, " ");
    }
    printf("\n");
}

void affiche_morse(char *texte){
    int indice=0;
    char carac;
    char minuscule;
    char ascii_a = texte_ref[0];
    char ascii_z = texte_ref[NB_LETTRES_ALPHA - 1];
    char ascii_0 = texte_ref[NB_LETTRES_ALPHA];
    char ascii_9 = texte_ref[NB_CARAC - 2];
    char ascii_space = texte_ref[NB_CARAC - 1];
    // pour éviter de faire une double boucle
    while (texte[indice] != '\0'){
        carac = texte[indice];
        minuscule = tolower(texte[indice]);
        if (carac >= ascii_a && carac <= ascii_z){ // entre 'a' et 'z'
            printf(" %s ", morse_ref[carac - ascii_a]);
        }
        else if (minuscule >= ascii_a && minuscule <= ascii_z){ // entre 'A' et 'Z'
            printf(" %s ", morse_ref[minuscule - ascii_a]);
        }
        else if (carac >= ascii_0 && carac <= ascii_9){ // entre '0' et '9'
            printf(" %s ", morse_ref[NB_LETTRES_ALPHA - 1 + carac - ascii_0]);
        }
        else if (carac == ascii_space){ // caractère ' '
            printf(" %s ", morse_ref[NB_CARAC - 1]);
        }
        indice++;
    }
    printf("\n");
}
