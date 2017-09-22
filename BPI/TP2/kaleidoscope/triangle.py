#¡/usr/bin/env python3
"""
module triangle_aleatoire
"""
from math import cos, sin
from random import randint
from point import Point

def triangle_aleatoire(limite_largeur, limite_hauteur):
    """
    fonction qui retourne un triangle aléatoire dans les limites imposées
    """
    # on créé 3 points aléatoires dont les coordonnées sont comprises
    # dont les coordonnées sont comprises dans la limite imposée en paramètres
    point_1 = Point([randint(limite_largeur[0], limite_largeur[1]),
                     randint(limite_hauteur[0], limite_hauteur[1])])
    point_2 = Point([randint(limite_largeur[0], limite_largeur[1]),
                     randint(limite_hauteur[0], limite_hauteur[1])])
    point_3 = Point([randint(limite_largeur[0], limite_largeur[1]),
                     randint(limite_hauteur[0], limite_hauteur[1])])
    # on retourne un objet triangle
    return Triangle(point_1, point_2, point_3)

class Triangle:
    """
    classe triangle
    """

    def __init__(self, point_1, point_2, point_3):
        """
        constructeur de la classe triangle
        """
        self.point_1 = point_1
        self.point_2 = point_2
        self.point_3 = point_3

    def rotation_autour(self, centre, angle):
        """
        méthode qui fait une rotation du triangle
        """
        self.point_1.coord_x_y = [(((self.point_1.coord_x_y[0] - centre.coord_x_y[0]) *
                                    cos(angle)) - ((self.point_1.coord_x_y[1] -
                                                    centre.coord_x_y[1]) * sin(angle)) +
                                   centre.coord_x_y[0]),
                                  (((self.point_1.coord_x_y[0] - centre.coord_x_y[0]) *
                                    sin(angle)) + ((self.point_1.coord_x_y[1] -
                                                    centre.coord_x_y[1]) * cos(angle)) +
                                   centre.coord_x_y[1])]
        self.point_2.coord_x_y = [(((self.point_1.coord_x_y[0] - centre.coord_x_y[0]) *
                                    cos(angle)) - ((self.point_1.coord_x_y[1] -
                                                    centre.coord_x_y[1]) * sin(angle)) +
                                   centre.coord_x_y[0]),
                                  (((self.point_1.coord_x_y[0] - centre.coord_x_y[0]) *
                                    sin(angle)) + ((self.point_1.coord_x_y[1] -
                                                    centre.coord_x_y[1]) * cos(angle)) +
                                   centre.coord_x_y[1])]
        self.point_3.coord_x_y = [(((self.point_1.coord_x_y[0] - centre.coord_x_y[0]) *
                                    cos(angle)) - ((self.point_1.coord_x_y[1] -
                                                    centre.coord_x_y[1]) * sin(angle)) +
                                   centre.coord_x_y[0]),
                                  (((self.point_1.coord_x_y[0] - centre.coord_x_y[0]) *
                                    sin(angle)) + ((self.point_1.coord_x_y[1] -
                                                    centre.coord_x_y[1]) * cos(angle)) +
                                   centre.coord_x_y[1])]
        return self # pour s'adapter à l'énoncé (mais déconseillé)
