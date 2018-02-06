/*
    Enonce :

    Il arrive parfois que la libc vous parle, et que vous fassiez la sourde
    oreille. En particulier, quand l'execution d'une fonction de la bibliotheque
    standard C se passe mal, il est tres frequent que cette fonction retourne
    une valeur bien choisie, documentee dans le manuel, et positionne un code
    d'erreur global (errno) qui represente le type d'erreur. On cherche ici a
    obtenir cette information via l'utilisation de la fonction perror().

    On vous fournit un programme simple qui ouvre et ferme un fichier. Le main()
    de ce programme peut executer deux scenarios differents, en fonction d'un
    nombre passe en argument sur la ligne de commande (soit 1, soit 2).

    Compilez ce programme. Si vous executez chacun des deux scenarios, vous vous
    rendrez compte qu'ils terminent tous sur une erreur de segmentation. En
    effet, l'execution de la fonction fopen() de la libc se passe mal dans les
    deux cas, mais comme on n'effectue aucune verification sur la valeur de
    retour, on passe a cote de cette erreur, et le programme termine en jus de
    boudin un peu plus loin.

    Modifiez le corps des fonctions ouvrir_fichier() et fermer_fichier() de
    maniere a tester les valeurs de retour des fonctions de la libc utilisees,
    et d'afficher un message explicite correspondant au type d'erreur rencontre
    le cas echeant. On utilisera pour cela la fonction perror(), dont vous lirez
    bien entendu le manuel.

    Une fois cette modification effectuee, verifiez que l'execution des deux
    scenarios affiche maintenant un message explicite avant de quitter le
    programme.

    Competences : 111
    Difficulte : 1
*/

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

/* Ouvre le fichier filename avec le mode d'acces mode. Retourne le FILE *
 * correspondant. */
static FILE *ouvrir_fichier(const char *filename, const char *mode) {
     FILE *fichier = fopen(filename, mode);
     return fichier;
}

/* Ferme le fichier passe en parametre. */
static void fermer_fichier(FILE *fichier) {
     int ret = fclose(fichier);
}

/* Fonction appelee quand la liste des arguments passes en ligne de commande
 * n'est pas correcte. */
static void usage(const char *progname) {
     /* On commence par raler... */
     fprintf(stderr, "Usage: %s n\n", progname);
     fprintf(stderr, "\tou n l'entier 1 ou 2.\n");
     /* ... puis on s'en va en claquant la porte. (la fonction exit(code) permet
      * de quitter le programme avec le code de retour passe en parametre.)*/
     exit(EXIT_FAILURE);
}

int main(int argc, char **argv)
{
     /* argv est un tableau de chaines de caracteres, de taille argc, dont
      * chaque element est un mot de la ligne de commande. Ainsi, argv[0]
      * represente le nom du programme, argv[1] le premier argument. */
     if (argc != 2) {
          /* On doit obligatoirement saisir un numero de scenario sur la ligne
           * de commande. */
          usage(argv[0]);
     }

     /* On convertit l'argument en ligne de commande, qui est une chaine de
      * caracteres en C, en entier. */
     uint8_t id = atoi(argv[1]);

     /* On aurait pu faire un switch() ici. */
     if (id == 1) {
          /* Premier scenario. */
          FILE *lecture_seule = ouvrir_fichier("lecture-seule.txt", "w");
          fermer_fichier(lecture_seule);
     } else if (id == 2) {
          /* Deuxieme scenario. */
          FILE *inexistant = ouvrir_fichier("t-es-pas-la-mais-t-es-ou.txt", "r");
          fermer_fichier(inexistant);
     } else {
          /* Le numero de scenario n'est pas bon, on rale. */
          usage(argv[0]);
     }

     return EXIT_SUCCESS;
}
