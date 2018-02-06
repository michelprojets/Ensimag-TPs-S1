/*
    Enonce :

    On manipule ici des fichiers en C. L'exercice consiste a programmer
    un equivalent a la commande 'cat' que vous connaissez deja, plus
    precisement au comportement de cette commande quand on lui fournit
    une liste de fichiers en parametre.

    Votre programme C devra donc ouvrir les fichiers passes en
    parametre, puis afficher leur contenu sur la sortie standard, les
    uns a la suite des autres. Si le programme est appele sans
    parametre, un message d'erreur s'affiche et le programme termine.

    Le code qui effectue l'ouverture du fichier, sa lecture, l'affichage
    de son contenu et sa fermeture sera place dans une fonction de
    prototype :

        void cat_file(const char *file_name);

    Competences : 48,49,50,56,67,70,74,85
    Difficulte : 2
*/

#include <stdlib.h>
#include <stdio.h>

void cat_file(const char *file_name){
    FILE* fichier = fopen(file_name, "r");  // pointeur de fichier
    if (fichier == NULL) {
        fprintf(stderr, "Problème ouverture fichier\n");
        exit(EXIT_FAILURE);
    }
    char carac = fgetc(fichier);
    // char* ligne;
    while (carac != EOF) {
        printf("%c", carac);
        carac = fgetc(fichier);
    }
    fclose(fichier);
}

int main(int argc, char **argv)
{
    if (argv[1] == NULL) {  // ou argc == 1
        fprintf(stderr, "Pas de paramètre\n");
        return EXIT_FAILURE;
    }
    for (int i=0; i<argc; ++i){
        cat_file(argv[i]);
    }
    return EXIT_SUCCESS;
}
