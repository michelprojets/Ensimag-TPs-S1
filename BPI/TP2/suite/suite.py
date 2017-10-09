#! /usr/bin/env python3

"""
module sous-suites
"""
import sys

def iter_nombres_fichier(str_fichier):
    """
    itérateur qui itère sur tous les nombres du fichier (sous forme de string)
    """
    lignes = []
    nombres = []
    lignes = str_fichier.split("\n")
    lignes.pop()  # pour enlever le dernier élément " " (il est rajouté à cause du split \n)
    for ligne in lignes:
        nombres += ligne.split(" ")
    for nombre in nombres:
        yield nombre

""" probleme : on commence à 0 et 1
"""
def iter_sous_suites_taille_max(str_fichier):
    """
    itérateur qui itère sur toutes les sous-suites monotones de taille la plus grande
    """
    sous_suite_monotone = []
    cpt_nombres_egaux = 0
    est_strict_croissant = None    # si false, sitrctement décroissant, si none, on ne sait pas
    iter_nombres = iter_nombres_fichier(str_fichier)
    # cas de base
    nombre_prec = next(iter_nombres)
    sous_suite_monotone.append(nombre_prec)
    # cas itératif
    for nombre in iter_nombres:
        if est_strict_croissant is None:    # au départ, on ne connait pas le sens de variation
            sous_suite_monotone.append(nombre)
        #####
        if nombre > nombre_prec and est_strict_croissant:   # strictement croissant
            sous_suite_monotone.append(nombre)
            cpt_nombres_egaux = 0
        elif nombre < nombre_prec and est_strict_croissant is False:  # strictement décroissant
            sous_suite_monotone.append(nombre)
            cpt_nombres_egaux = 0
        elif nombre == nombre_prec: # égal
            sous_suite_monotone.append(nombre)
            cpt_nombres_egaux += 1
        elif nombre > nombre_prec and est_strict_croissant is False: # strictement croissant et
                                                                     # changement variation
            yield sous_suite_monotone
            sous_suite_monotone.clear()
            sous_suite_monotone.append(nombre_prec)
            cpt_nb_egaux = 0
            while cpt_nb_egaux < cpt_nombres_egaux:
                sous_suite_monotone.append(nombre_prec)
                cpt_nb_egaux += 1
            sous_suite_monotone.append(nombre)
            cpt_nombres_egaux = 0
        elif nombre < nombre_prec and est_strict_croissant: # strictement décroissant
                                                            # et changement variation
            yield sous_suite_monotone
            sous_suite_monotone.clear()
            sous_suite_monotone.append(nombre_prec)
            cpt_nb_egaux = 0
            while cpt_nb_egaux < cpt_nombres_egaux:
                sous_suite_monotone.append(nombre_prec)
                cpt_nb_egaux += 1
            sous_suite_monotone.append(nombre)
            cpt_nombres_egaux = 0
        #####
        if nombre > nombre_prec:
            est_strict_croissant = True
        elif nombre < nombre_prec:
            est_strict_croissant = False
        #####
        nombre_prec = nombre
    # on retourne le reste (la dernière liste) vu qu'il n'y a pas de changement de
    # variation (puisque c'est la fin)
    yield sous_suite_monotone

def max_suite(str_fichier):
    """
    fonction qui retourne la plus grande sous-suite dans un fichier (sous forme de string)
    """
    sous_suites = []
    for sous_suite in iter_sous_suites_taille_max(str_fichier):
        #print(sous_suite)   # pour test
        sous_suites.append(list(sous_suite))
    return max(sous_suites, key=len)    # retourne la sous_suite dont la longueur est la plus grande

def main():
    """
    programme principal
    """
    if len(sys.argv) != 2 or sys.argv[0] == "-h" or sys.argv[0] == "--help":
        print("utilisation:", sys.argv[0], "fichier.txt")
        sys.exit(1)

    fichier = open(sys.argv[1], "r")
    str_fichier = fichier.read()
    print("=>", max_suite(str_fichier))
    fichier.close()

if __name__ == "__main__":
    main()
