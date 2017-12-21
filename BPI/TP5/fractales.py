#! /usr/bin/env python3
"""
module fractales
"""
from math import sqrt, cos, sin, pi
from random import randint
from point import Point

LARGEUR = 500
HAUTEUR = 500
NB_BRANCHES = 3
PART = 12
RATIO = 1.8

class Branche():
    """
    classe Branche composé de deux Points
    """
    def __init__(self, point_1, point_2):
        """
        constructeur de la classe Branche
        """
        self.point_1 = point_1
        self.point_2 = point_2
        self.longueur = sqrt((point_2.coord_x - point_1.coord_x)**2 +
                             (point_2.coord_y - point_1.coord_y)**2)

def generer_arbre(branche_mere):
    """
    fonction récursive qui génère un arbre en svg
    """
    # cas d'arrêt
    if branche_mere.longueur == 0:   # cas d'arrêt
        pass
    else: # cas récursif
        print("<line x1=\"" + str(branche_mere.point_1.coord_x) + "\" y1=\"" +
              str(branche_mere.point_1.coord_y) + "\" x2=\"" +
              str(branche_mere.point_2.coord_x) + "\" y2=\"" +
              str(branche_mere.point_2.coord_y) + "\" stroke=\"black\" stroke-width=\"1\"/>")
        for _ in range(NB_BRANCHES):  # on multiplie par 3 branches à chaque fois
            angle_rad = (randint(1, PART-1)/PART)*pi
            longueur = branche_mere.longueur//RATIO
            if longueur <= 0:
                longueur = 0
            point_1 = Point(branche_mere.point_2.coord_x, branche_mere.point_2.coord_y)
            point_2 = Point(int(branche_mere.point_2.coord_x + longueur*cos(angle_rad)),
                            int(branche_mere.point_2.coord_y - longueur*sin(angle_rad)))
            branche = Branche(point_1, point_2)
            generer_arbre(branche)

def main():
    """
    programme principal
    """
    print("<svg width=\"" + str(LARGEUR) + "\" height=\"" + str(HAUTEUR) + "\">")
    # cas initial
    branche = Branche(Point(LARGEUR//2, HAUTEUR), Point(LARGEUR//2, int((3/5)*HAUTEUR)))
    generer_arbre(branche)
    print("</svg>")

if __name__ == "__main__":
    main()
