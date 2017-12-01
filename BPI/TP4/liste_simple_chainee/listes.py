#!/usr/bin/env python3
"""
listes simplements chainees + quelques operations
"""
#from tycat import trace


class Cellule:
    """
    une cellule d'une liste. contient une valeur et un pointeur
    vers la cellule suivante.
    """
    # pylint: disable=too-few-public-methods
    def __init__(self, valeur, suivant=None):
        self.valeur = valeur
        self.suivant = suivant


class Liste:
    """
    une liste simplement chainee.
    contient un pointeur sur la cellule en tete de liste et un autre sur
    la queue de liste.
    un compteur permet de savoir rapidement la taille de la liste.
    """
    def __init__(self):
        self.tete = None
        self.queue = None
        self.taille = 0

    def est_vide(self): # méthode ajoutée
        """
        renvoie true si la liste est vide, false sinon
        """
        return self.taille == 0

    #@trace
    def ajouter_en_tete(self, valeur):
        """
        ajoute une cellule en tete. cout : O(1).
        """
        premier = Cellule(valeur)
        if self.est_vide():
            self.queue = premier
        else:
            premier.suivant = self.tete
        self.tete = premier
        self.taille += 1

    #@trace
    def ajouter_en_queue(self, valeur):
        """
        ajoute une cellule en queue. cout : O(1).
        on peut le faire rapidement grace au pointeur de queue.
        """
        dernier = Cellule(valeur)
        if self.est_vide():
            self.tete = dernier
        else:
            self.queue.suivant = dernier
        self.queue = dernier
        self.taille += 1


    def cellules(self): # itérateur safe
        """
        iterateur sur chaque cellule.
        """
        if self.est_vide():
            return
        courant = self.tete
        suivant = courant.suivant   # première sauvegarde du suivant
        while courant is not None:
            yield courant
            courant = suivant
            if courant is not None:
                suivant = courant.suivant   # sauvegarde itérée du suivant

    def recherche(self, valeur):
        """
        renvoie la premiere cellule contenant la valeur donnee.
        """
        if self.est_vide():
            return None
        for cel in self.cellules():
            if cel.valeur == valeur:
                return cel
        return None

    #@trace
    def supprimer(self, valeur):
        """
        enleve la premiere cellule contenant la valeur donnee.
        """
        if self.est_vide():
            return
        if self.taille == 1:    # liste à un élément
            if self.tete.valeur == valeur:
                self.tete = None
                self.queue = None
                self.taille = 0
            else:
                return
        else:   # liste à au moinx deux éléments
            if self.tete.valeur == valeur:  # si la cellule à supprimer est la première
                self.tete = self.tete.suivant
                self.taille -= 1
            else:
                for cel in self.cellules():
                    if cel.suivant is not None: # pour éviter les erreurs
                        if cel.suivant.valeur == valeur:
                            # si la cellule à supprimer n'est pas la dernière
                            if cel.suivant.suivant is not None:
                                cel.suivant = cel.suivant.suivant
                                self.taille -= 1
                                break
                            else:   # si la cellule à supprimer est la dernière
                                cel.suivant = None
                                self.queue = cel
                                self.taille -= 1

    def __str__(self):
        """
        affiche (val1, val2, val3....)
        """
        if self.est_vide():
            return "()"
        liste_str = "("
        for cel in self.cellules():
            liste_str += str(cel.valeur)
            if cel.suivant is None: # si c'est la dernière cellule
                liste_str += ")"
            else:
                liste_str += ", "
        return liste_str


def test_listes():
    """
    on teste toutes les operations de base, dans differentes configurations.
    """
    exemple = Liste()
    exemple.ajouter_en_tete(3)
    exemple.ajouter_en_tete(5)
    exemple.ajouter_en_queue(2)
    exemple.ajouter_en_queue(4)
    print("exemple : ", exemple)
    print("recherche : ", exemple.recherche(3).valeur)
    print("adresses des cellules : ",
          ",".join([hex(id(c))for c in exemple.cellules()]))
    exemple.supprimer(5)
    print("apres suppression de 5 : ", exemple)
    exemple.supprimer(4)
    print("apres suppression de 4 : ", exemple)

if __name__ == "__main__":
    test_listes()
