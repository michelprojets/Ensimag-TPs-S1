#! /usr/bin/env python3
"""
module principal image pgm
"""
from random import randint
from math import sqrt
from point import Point
def calcul_distance(point_1, point_2):
    """
    calcule la distance entre deux points
    """
    return (sqrt((point_2.coord_x - point_1.coord_x)**2 +
                 (point_2.coord_y - point_1.coord_y)**2))

def main():
    """
    programme principal
    """
    print("P2")
    largeur = 0
    hauteur = 0
    largeur = int(input())
    hauteur = int(input())
    print(largeur, end=" ")
    print(hauteur) # largeur et hauteur de l'image
    print("255")
    centre_1 = Point(randint(0, hauteur/2), randint(0, largeur/2))  # création d'un centre random.
    rayon_1 = Point(randint(0, hauteur/2), randint(0, largeur/2))   # création d'un rayon random
    distance_rayon_1 = calcul_distance(centre_1, rayon_1)   # distance du rayon 1
    centre_2 = Point(randint(0, hauteur/2), randint(0, largeur/2))  # création d'un autre centre random.
    rayon_2 = Point(randint(0, hauteur/2), randint(0, largeur/2))   # création d'un autre rayon random
    distance_rayon_2 = calcul_distance(centre_2, rayon_2)   # distance du rayon 2
    point = Point()
    for cpt_hauteur in range(hauteur):
        for cpt_largeur in range(largeur):
            point.set_coords(cpt_hauteur, cpt_largeur)
            # si le point est dans le premier disque ou dans le deuxieme disque
            if (calcul_distance(centre_1, point) <= distance_rayon_1 or
                    calcul_distance(centre_2, point) <= distance_rayon_2):
                if cpt_largeur == largeur - 1:
                    print(randint(0, 255), end="")
                else:
                    print(randint(0, 255), end=" ")
            else:   # sinon à l'extérieur des deux disques
                if cpt_largeur == largeur - 1:
                    print("255", " ", end="")
                else:
                    print("255", " ", end=" ")
        print(end="\n")
main()
