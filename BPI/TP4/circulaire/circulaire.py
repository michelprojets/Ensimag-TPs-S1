#!/usr/bin/env python3
"""
listes triees, circulaires avec sentinelle.
"""
#from tycat import trace

class Cellule:
    """
    valeur + suivant
    """
    #pylint: disable=too-few-public-methods
    def __init__(self, valeur, suivant=None):
        self.valeur = valeur
        self.suivant = suivant

class Liste:
    """
    liste circulaire triee, simplement chainee avec sentinelle.
    """
    def __init__(self, sentinelle, iterable=None):
        """
        remplit la liste avec les elements de l'iterable donne.
        'sentinelle' precise la valeur de la cellule sentinelle
        pre-condition: l'iterable donne est trie.
        """
        # ATTENTION : comme on suppose que la liste est initialement triée, on ne doit pas utiliser
        # la méthode self.ajouter(valeur) car cette dernière ne suppose pas que la liste soit
        # initialiement triée
        self.tete = Cellule(sentinelle)
        courant = self.tete
        if iterable is None:
            courant.suivant = self.tete
            return
        for val in iterable:
            courant.suivant = Cellule(val)
            courant = courant.suivant
        courant.suivant = self.tete # la dernière cellule pointe vers la sentinelle

    def est_vide(self): # méthode ajoutée
        """
        renvoie true si la liste est vide, false sinon
        """
        return self.tete.suivant == self.tete

    def cellules(self, inclure_sentinelle=False):   # itérateur safe
        """
        renvoie un iterateur sur toutes les cellules de la liste.
        'inclure_sentinelle' est un booleen permettant de preciser
        si la sentinelle est inclue ou non dans les cellules iterees.
        """
        if inclure_sentinelle:
            yield self.tete
        if self.est_vide():
            return
        courant = self.tete.suivant
        suivant = courant.suivant   # premiere sauvegarde du suivant
        while courant != self.tete:
            yield courant
            courant = suivant
            suivant = courant.suivant   # sauvegarde itérée du suivant

    #@trace
    def decoupe(self):
        """
        coupe la liste en 2 (une cellule sur 2).
        par exemple (1,4,2,3,5) devient (1,2,5) et (4,3).
        renvoie les deux nouvelles listes.
        aucune nouvelle cellule n'est creee.
        """
        # cas particuliers
        if self.est_vide():
            return (None, None)
        if self.tete.suivant.suivant == self.tete:  # si la liste ne contient qu'un seul élément
            return (self, None)

        # ici, la liste contient au moinx deux éléments
        # initialisation des listes et du flag
        liste_indices_impaires = Liste(float("inf"))
        liste_indices_paires = Liste(float("inf"))
        flag = True

        # cas initial
        cellules = self.cellules()
        premiere_cellule = next(cellules)
        premiere_cellule.suivant = liste_indices_impaires.tete
        liste_indices_impaires.tete.suivant = premiere_cellule
        deuxieme_cellule = next(cellules)
        deuxieme_cellule.suivant = liste_indices_paires.tete
        liste_indices_paires.tete.suivant = deuxieme_cellule

        # cas itéré (problème de safety à gérer :
        # il faut laisser passer une itération avant de brancher les cellules
        for cel in cellules:
            if flag:
                for cell in liste_indices_impaires.cellules():
                    if cell.suivant == liste_indices_impaires.tete:
                        # le suivant de la cellule courante devient
                        # la sentinelle de la liste impaire
                        cel.suivant = liste_indices_impaires.tete
                        # le suivant du dernier de la liste impaire devient
                        # la cellule courante (voir juste dessus)
                        cell.suivant = cel
                flag = False
            else:
                for cell in liste_indices_paires.cellules():
                    if cell.suivant == liste_indices_paires.tete:
                        # le suivant de la cellule courante devient
                        # la sentinelle de la liste paire
                        cel.suivant = liste_indices_paires.tete
                        # le suivant du dernier de la liste paire devient
                        # la cellule courante (voir juste dessus)
                        cell.suivant = cel
                flag = True
        return (liste_indices_impaires, liste_indices_paires)

    def ajouter(self, valeur):
        """
        ajoute la valeur donnee a la bonne place dans la liste.
        """
        if self.est_vide():
            self.tete.suivant = Cellule(valeur, self.tete)
        else:
            for cel in self.cellules(True): # pour commencer à partir de l'élément -1
                if valeur <= cel.suivant.valeur:
                    cel.suivant = Cellule(valeur, cel.suivant)
                    break   # pour ne pas ajouter plusieurs fois et pour éviter d'itérer pour rien
            # pas besoin de traiter le cas où on doit ajouter en fin de liste
            # car on a mis une valeur de la sentinelle = inf pour nous arranger
            # vu que valeur sera toujours inférieure à inf

    def supprimer(self, valeur):
        """
        supprime la premiere cellule contenant la valeur donnee.
        """
        if self.est_vide():
            return
        else:   # liste à au moinx un élément
            for cel in self.cellules(True): # pour commencer à partir de l'élément -1
                if cel.suivant != self.tete: # si ce n'est pas la fin de la liste
                    if cel.suivant.valeur == valeur:
                        cel.suivant = cel.suivant.suivant

    def __str__(self):
        """
        renvoie la liste sous forme d'une chaîne de caractères
        """
        if self.est_vide():
            return "()"
        liste_str = "("
        for cel in self.cellules():
            liste_str += str(cel.valeur)
            if cel.suivant == self.tete: # si c'est la dernière cellule
                liste_str += ")"
            else:
                liste_str += ", "
        return liste_str

def test():
    """
    tests simples des differentes methodes.
    """
    entiers = Liste(float("inf"), range(8))
    pairs, impairs = entiers.decoupe()
    print(pairs, impairs)
    pairs.supprimer(4)
    pairs.supprimer(0)
    pairs.supprimer(2)
    pairs.supprimer(6)
    impairs.ajouter(6)
    impairs.ajouter(0)
    print(pairs, impairs)

if __name__ == "__main__":
    test()
