#ifndef _MORSE_H_
#define _MORSE_H_

/* help : fonction affichant tout le tableau du code morse pouvant
   etre code ou decode par ce programme*/
extern void help();

/* affiche_texte : fonction affichant le texte correspondant au code morse passe en parametre */
extern void affiche_texte(char *morse);

/* affiche_morse : fonction affichant le code Morse correspondant au texte passe en parametre */
extern void affiche_morse(char *texte);

#endif  /* _MORSE_H_ */
