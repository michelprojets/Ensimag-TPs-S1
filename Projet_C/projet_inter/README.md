generation automatique du fichier executable avec "make"

les fonctions de base on été implantés et les tests sont effectués dans le main
(avec création de jeu de données et avec affichage en sortie standard de l'état
de l'annuaire à chaque fois)

l'optimisation a été implanté également mais possède des bugs
donc j'ai commenté la ligne de code qui fait appel à la fonction maj_annuaire()

valgrind affiche 0 erreur et 0 fuite mémoire
