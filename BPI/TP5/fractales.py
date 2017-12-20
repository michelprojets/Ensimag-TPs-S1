#! /usr/bin/env python3
"""
module fractales
"""
from math import sqrt
from point import Point

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
        self.longueur = sqrt((point_1.coord_x - point_2.coord_x)**2 +
                             (point_1.coord_y - point_2.coord_y)**2)

def generer_arbre(branche):
    """
    fonction récursive qui génère un arbre en svg
    """
    # cas d'arrêt
    if self.longueur <= (1/10)*branche.longueur:
        print("<line x1=\"" + str(branche.point_1.coord_x) + "\" y1=\"" +
              str(branche.point_1.coord_y) + "\" x2=\"" +
              str(branche.point_2.coord_x) + "\" y2=\"" +
              str(branche.point_2.coord_y) +
              "\" stroke=\"black\" stroke-width=\"8\"/>")
    else: # cas récursif
        for _ in range(3):
            generer_arbre(branche)

def main():
    """
    programme principal
    """
    print("<svg width=\"500\" height=\"500\">")
    # cas initial
    print("<line x1=\"250\" y1=\"500\" x2=\"250\"" +
          "y2=\"350\" stroke=\"black\" stroke-width=\"8\"/>")
    branche = Branche(Point(250,500), Point(250,350))
    generer_arbre(branche)
    print("</svg>")

if __name__ == "__main__":
    main()
