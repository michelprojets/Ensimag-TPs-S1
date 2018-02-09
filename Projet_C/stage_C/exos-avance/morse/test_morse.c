#include <stdio.h>
#include <stdlib.h>
#include "morse.h"

/* main */
int main()
{
    help(); // Affiche la correspondance des caracteres pris en charge et des codes Morse
    printf("Affichage du code Morse de la phrase : \"RMS Titanic SOS\"\n");
    affiche_morse("RMS Titanic SOS");
    // char texte[] = "RMS Titanic SOS5";
    // affiche_morse(texte);
    printf("Affichage de la traduction du code Morse : \".-. -- ... // - .. - .- -. .. -.-. // ... --- ... // .---- ..... // .- ...- .-. .. .-.. // .---- ---. .---- ..---\"\n");
    affiche_texte(".-. -- ... //  - .. - .- -. .. -.-. // ... --- ... // .---- ..... // .- ...- .-. .. .-.. // .---- ---. .---- ..---");
    // mieux et en plus, POUR EVITER DE FAIRE UNE COPIE DE LA CHAINE DANS affiche_texte()
    // char morse[] = ".-. -- ... //  - .. - .- -. .. -.-. // ... --- ... // .---- ..... // .- ...- .-. .. .-.. // .---- ---. .---- ..---";
    // affiche_texte(morse);
    return EXIT_SUCCESS;
}
