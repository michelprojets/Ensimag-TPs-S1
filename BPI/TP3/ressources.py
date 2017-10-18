#!/usr/bin/env python3
"""
manipulations complexes de tableaux : listes d'intervalles.
"""


class Ressources:
    """
    On stocke une liste de ressources, compressee par plages contigues.
    """
    def __init__(self, nombre_ressources, intervalles=None):
        # invariant : les intervalles sont tries par indices croissants
        self.nombre_ressources = nombre_ressources
        if intervalles is not None:
            self.intervalles = intervalles
        else:
            self.intervalles = [[0, nombre_ressources]]

    def disponible(self, indice):
        """
        renvoie si l'indice donne est disponible dans la ressource.
        """
        for i in range(len(self.intervalles)):
            for j in range(self.intervalles[i][0], self.intervalles[i][1]):
                if indice == j:
                    return True
        return False


    def reserve(self, ressources_demandees):
        """
        enleve le nombre de ressources demandees (premieres disponibles).
        renvoie les ressources correspondant aux plages reservees.
        """

        # on vérifie d'abord si le nombre de ressources_demandees est
        # inférieur ou égal au nombre de ressources disponibles
        nb_ressources_dispo = 0
        cpt = 0
        while cpt < self.nombre_ressources:
            if self.disponible(cpt):
                nb_ressources_dispo += 1
            cpt += 1
        if ressources_demandees > nb_ressources_dispo:
            return

        # on commence l'algorithme de la fonction
        intervalles = []
        change = 0  # pour permettre de savoir l'intervalle courant à modifier
        intervalles.append([self.intervalles[0][0], self.intervalles[0][0]])
        while ressources_demandees > 0:
            intervalles[change][1] += 1
            self.intervalles[0][0] += 1
            if self.intervalles[0][0] == self.intervalles[0][1]:    # si l'intervalle est [a,a]
                self.intervalles.pop(0) # diminue les ressources de self
                if len(self.intervalles) != 0:   # pour éviter l'exception (plus d'intervalles)
                    intervalles.append([self.intervalles[0][0], self.intervalles[0][0]])
                change += 1 # on change d'intervalle
            ressources_demandees -= 1
        return Ressources(self.nombre_ressources, intervalles)

    def retourne(self, ressources_rendues):
        """
        remet les plages de ressources donnees dans le systeme.
        """
        for intervalle in ressources_rendues.intervalles:
            self.intervalles.append(intervalle)

    def __str__(self):
        """
        renvoie une chaine 'visuelle' des ressources contenues dans self.
        par exemple, '|x  xxxxx  |' indique qu'il y a 10 ressources,
        les ressources 0, 3-7 sont disponibles.
        """
        chaine = "|"
        for i in range(self.nombre_ressources):
            if self.disponible(i):
                chaine += "x"
            else:
                chaine += "."
        chaine += "|"
        return chaine

def test():
    """
    on teste en gruyerisant une ressource.
    """
    ressource = Ressources(10)
    print(ressource)
    reservees = [ressource.reserve(c) for c in (2, 2, 3, 2, 1)]
    print(ressource)
    ressource.retourne(reservees[1])
    print(ressource)
    ressource.retourne(reservees[3])
    print(ressource)
    ressource.reserve(3)
    print(ressource)
    print(ressource.intervalles)

if __name__ == "__main__":
    test()
