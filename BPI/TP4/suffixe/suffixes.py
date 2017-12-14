#!/usr/bin/env python3
"""
listes avec partages de suffixes.
"""
from tycat import data_tycat


class Cellule:
    """
    une cellule d'une liste. contient une valeur, un pointeur
    vers la cellule suivante, un compteur comptabilisant
    combien de listes ou de cellules pointent dessus.
    """
    # pylint: disable=too-few-public-methods
    def __init__(self, valeur, suivant=None):
        self.valeur = valeur
        self.suivant = suivant
        self.utilisation = 1

class Liste:
    """
    liste de cellules.
    des listes differentes peuvent partager des cellules communes.
    """
    def __init__(self, mot):
        """
        transforme un mot en liste non-partagee.
        """
        premiere_cellule = None
        self.taille = 0
        for lettre in reversed(mot):
            premiere_cellule = Cellule(lettre, premiere_cellule)
            self.taille += 1
        self.tete = premiere_cellule

    def cellules(self): # itérateur rendu safe
        """
        iterateur sur toute les cellules de la liste.
        """
        cellule_courante = self.tete
        while cellule_courante is not None:
            cellule_suivante = cellule_courante.suivant # sauvegarde
            yield cellule_courante
            cellule_courante = cellule_suivante # récupération de la sauvegarde

    def suffixe(self, autre):
        """
        ajoute la liste autre a la fin de la liste self
        (en partageant les cellules communes).
        si la fin de self etait deja partagee avec quelqu'un, alors
        on dedouble toute la partie partagee avant l'ajout.
        """
        if autre.tete is None:  # liste vide
            return

        partage = False # boolean qui indique si la liste partage au moins une cellule ou pas
        for cel in self.cellules():
            if cel.utilisation > 1: # dès qu'on trouve une cellule partagée
                partage = True
                break

        if partage: # si la liste partage des cellules
            vu_premiere = True
            doublage = False
            premiere = True
            prec = self.tete
            for cel in self.cellules():
                if vu_premiere and cel.utilisation > 1: # dès qu'on trouve une cel partagée (1 fois)
                    vu_premiere = False
                    doublage = True
                    cel.utilisation -= 1
                if doublage:    # si on commence à doubler la partie partagée
                    cel_double = Cellule(cel.valeur)
                    if premiere:    # cas initial (1 fois)
                        premiere = False
                        if cel == self.tete:    # si c'est la première cellule qu'on supprime
                            self.tete = cel_double
                        else:   # cas général
                            prec.suivant = cel_double
                    else:   # cas itératif
                        prec.suivant = cel_double
                    prec = cel_double
                else:
                    prec = cel
            prec.suivant = autre.tete
            autre.tete.utilisation += 1

        else: # sinon, si la liste ne partage aucune cellule
            if partage is False:
                for cel in self.cellules():
                    if cel.suivant is None:
                        cel.suivant = autre.tete
                        autre.tete.utilisation += 1

        self.taille += autre.taille

    def __del__(self):
        """
        destructeur.
        """
        for cel in self.cellules():
            if cel.utilisation > 1: # cellule utilisée par d'autres listes
                cel.utilisation -= 1
                break   # pour ne pas modifier les autres utilisation
            else:   # nettoyage (facultatif)
                cel.suivant = None
        self.tete = None

def test_listes():
    """
    on teste toutes les operations de base, dans differentes configurations.
    """
    listes = [Liste(mot) for mot in ("SE", "PAS", "DE", "DEVIS")]
    data_tycat(listes)
    _ = input()
    print("on ajoute listes[0] apres liste[1], puis un mot vide")
    listes[1].suffixe(listes[0])
    listes[1].suffixe(Liste(""))
    data_tycat(listes)
    _ = input()
    print("on ajoute listes[1] apres listes[2] et listes[0] apres listes[3]")
    listes[2].suffixe(listes[1])
    listes[3].suffixe(listes[0])
    data_tycat(listes)
    _ = input()
    print("on efface 'DEVIS'")
    del listes[3]
    data_tycat(listes)
    _ = input()
    # # test dans le cas où le doublage ne se fait pas à la tête de la liste
    # print("on efface 'DEPASSE'")
    # del listes[2]
    # data_tycat(listes)
    # _ = input()
    print("on ajoute 'NT' apres 'PASSE'")
    listes[1].suffixe(Liste("NT"))
    data_tycat(listes)
    _ = input()
    print("on ajoute 'SE' apres elle-meme")
    listes[0].suffixe(listes[0])
    data_tycat(listes)

if __name__ == "__main__":
    test_listes()
