#! /usr/bin/env python3
"""
module comportant la classe Point
"""
class Point:
    """
    classe Point de deux coordonnées
    """

    def __init__(self, coord_x=0, coord_y=0):
        """ constructeur """
        # abscisse
        self.coord_x = coord_x
        # ordonnée
        self.coord_y = coord_y

    def __str__(self):
        """ renvoie la chaine de caractere qui represente le Point """
        return str(self.coord_x) + " " + str(self.coord_y)
