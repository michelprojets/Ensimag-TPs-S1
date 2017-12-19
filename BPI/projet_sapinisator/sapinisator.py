#! /usr/bin/env python3
"""
module sapiniser
"""

from math import fabs, sin
from struct import Struct

class Point:
    """
    classe point
    """
    def __init__(self, coord_x=0, coord_y=0, coord_z=0):
        """
        constructeur
        """
        self.coord_x = coord_x
        self.coord_y = coord_y
        self.coord_z = coord_z

    def set_coords(self, coord_x, coord_y, coord_z):
        """
        modifie les coordonnées d'un point
        """
        self.coord_x = coord_x
        self.coord_y = coord_y
        self.coord_z = coord_z

    def __add__(self, point_2):
        """
        override de la méthode __add__ '+'
        """
        self.set_coords(self.coord_x + point_2.coord_x, self.coord_y + point_2.coord_y,
                        self.coord_z + point_2.coord_z)

    def __sub__(self, point_2):
        """
        override de la méthode __sub__ '-'
        """
        self.set_coords(self.coord_x - point_2.coord_x, self.coord_y - point_2.coord_y,
                        self.coord_z - point_2.coord_z)

    def __str(self):
        """
        méthode tostring
        """
        return "(" + self.coord_x + ", " + self.coord_y + ", " + self.coord_z + ")"

def moyenne_points(points):
    """
    fonction qui calcul et qui retourne un centre approximatif (moyenne des points)
    """
    moyenne_x = moyenne_y = moyenne_z = 0.0
    nb_points = 0
    for point in points:
        moyenne_x += point.coord_x
        moyenne_y += point.coord_y
        moyenne_z += point.coord_z
        nb_points += 1
    return Point(moyenne_x/nb_points, moyenne_y/nb_points, moyenne_z/nb_points)

def facteur_aggrandissement(coord):
    """
    fonction qui à la coordonnée coord retourne son facteur d'aggrandissement
    """
    param_s = 100 # paramètre s fixé
    return coord*fabs(sin(param_s*coord))

def fonction_aggrandissement(point, facteur):
    """
    fonction qui multiplie les coordonnées x et y (pas z) du point par un facteur d'aggrandissement
    """
    point.set_coords(point.coord_x*facteur, point.coord_y*facteur, point.coord_z)

def sapinisation(points):
    """
    fonction qui va pour chaque point de points calcule le point de sapinisation associé
    """
    centre = moyenne_points(points)
    for point in points():
        facteur = facteur_aggrandissement(point.coord_z)
        point -= centre
        fonction_aggrandissement(point, facteur)
        point += centre

def main():
    """
    programme principal
    """


if __name__ == "__main__":
    main()
