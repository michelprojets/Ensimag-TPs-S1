#!/usr/bin/env python3
"""
on fait une analyse de texte pour dessiner le graphe des mots suivants.
permet l'utilisation de dictionnaires et une imbrication de structures.
on se sert des donnees pour generer des phrases aleatoires.
"""
import sys
from re import finditer
from random import choice, randint
from os import system


def mots(nom_fichier):
    """
    renvoie un iterateur sur tous les mots du fichier.
    elimine au passage tous ce qui n'est pas une lettre.
    """
    with open(nom_fichier, "r") as fichier:
        for ligne in fichier:
            for mot in finditer("[a-zA-Z]+", ligne):
                yield mot.group(0)


def couples(iterateur):
    """
    renvoie un iterateur sur tous les couples d'elements successifs
    de l'iterateur donne.
    """
    valeur_precedente = next(iterateur)
    for valeur in iterateur:
        yield valeur_precedente, valeur
        valeur_precedente = valeur


def compte_mots_suivants(nom_fichier):
    """
    renvoie un dict associant a chaque mot m1 du fichier
    un dict associant a chaque mot m2 suivant m1 dans le fichier
    le nombre de fois ou m2 apparait apres m1.
    """
    # initialisation du dictionnaire contenant chaque mot m1 du fichier
    dict_mots = dict()
    for mot in mots(nom_fichier):
        if mot not in dict_mots:
            dict_mots.update({mot : dict()})
    # remplissage du dict associant à chaque mot, les mots suivants et
    # leur nombre d'occurrences
    for couples_mots in couples(mots(nom_fichier)):
        # si le mot suivant n'existe pas encore, on l'initialise
        if couples_mots[1] not in dict_mots[couples_mots[0]]:
            dict_mots[couples_mots[0]].update({couples_mots[1] : 1})
        else:   # sinon, on incrémente le compteur
            dict_mots[couples_mots[0]][couples_mots[1]] += 1
    return dict_mots


def affiche_graphe(suivants):
    """
    affiche le graphe dans le terminal.
    attention: petits textes seulement.
    """
    with open("test.dot", "w") as fichier_dot:
        fichier_dot.write("digraph g { \n")
        for mot, mots_suivants in suivants.items():
            for mot_suivant, nb_occu in mots_suivants.items():
                line = (str(mot) + "->" + str(mot_suivant) +
                        "[label=" + str(nb_occu) + "]; \n")
                fichier_dot.write(line)
        fichier_dot.write("}")
    system("dot -Tpng test.dot -o test.png")
    system("tycat test.png")

def analyse_texte():
    """
    analyse le fichier donne et dessine le graphe
    des mots suivants.
    """
    if len(sys.argv) != 2:
        print("utilisation :", sys.argv[0], "fichier_texte")
        sys.exit(1)
    suivants = compte_mots_suivants(sys.argv[1])
    affiche_graphe(suivants)
    # clonage
    input() # pause
    affiche_graphe(clonage_dict(suivants))
    # une petite phrase aleatoire.
    mot_depart = choice(list(suivants.keys()))  # mot de départ
    phrase = [mot_depart]
    for _ in range(10):
        # reprend à chaque fois le dernier mot de la phrase en cours de construction
        # comme une suite
        phrase.append(suivant_aleatoire(phrase[-1], suivants))
    print(" ".join(phrase))


def suivant_aleatoire(mot, suivants):
    """
    tire aleatoirement (uniformement en fonction des frequences)
    un suivant du mot donne.
    si le mot donne n'a pas de suivant, retourne un mot aleatoire.
    """
    nb_suivants = 0
    if len(suivants[mot]) > 0:
        # tire aléatoirement (uniformément en fonction des fréquences)
        for nb_occu in suivants[mot].values():
            nb_suivants += nb_occu
        indice_alea = randint(0, nb_suivants - 1)
        for mot_suivant, nb_occu in suivants[mot].items():
            indice_alea -= nb_occu
            if indice_alea < 0: # strictement inférieur car on décrémente indice_alea juste avant
                return mot_suivant
            # # autre méthode
            # for _ in range(nb_occu):
            #     if indice_alea == 0:
            #         return mots_suivant
            #     indice_alea -= 1
            # #######################
    else:   # retourne un mot aléatoire
        return choice(list(suivants.keys()))

def clonage_dict(suivants): # fonction bonus
    """
    clone un dictionnaire (recopie)
    et renvoie ce nouveau dictionnaire
    """
    # première recopie (premier dictionnaire)
    clone_suivants = dict()
    for mot in suivants.keys():
        clone_suivants.update({mot : dict()})
    # deuxième recopie (dictionnaire à chaque élément du dictionnaire général)
    for mot in clone_suivants.keys():
        for mot_suivant in suivants[mot].keys():
            clone_suivants[mot].update({mot_suivant : suivants[mot][mot_suivant]})
    return clone_suivants
    # # si on essaye de copier les dictionnaires, il y aura copie de référence
    # # car dict est non mutable
    # clone_suivants = dict()
    # for mot in suivants.keys():
    #     clone_suivants.update({mot : dict()})
    # for mot in suivants.keys():
    #     clone_suivants[mot] = suivants[mot]
    # # test pour savoir s'il y a eu des copies de références ou non
    # clone_suivants["serpent"]["python"] = 3
    # return clone_suivants
    

if __name__ == "__main__":
    analyse_texte()
