#!/usr/bin/env python3
"""
kaleidoscope.
exo graphique, quelques boucles, plusieurs classes a ecrire.
"""
import sys
from math import pi

import svg
from point import Point
from triangle import triangle_aleatoire


def generer_image(nombre_triangles):
    """
    genere le nombre de triangles demande aleatoirement, les tourne.
    affiche le svg sur la sortie standard.
    """
    largeur, hauteur = 800.0, 600.0
    svg.entete(largeur, hauteur)
    centre = Point([largeur/2, hauteur/2])

    for _ in range(nombre_triangles):
        # on genere un triangle a l'interieur du quart en bas
        # a droite de l'image.
        triangle = triangle_aleatoire(
            (largeur/2, largeur),
            (hauteur/2, hauteur)
        )
        couleur = svg.couleur_aleatoire()
        # on tourne 8 fois
        for tour in range(8):
            angle = pi/4 * tour
            triangle_tourne = triangle.rotation_autour(centre, angle)
            svg.affiche_triangle(triangle_tourne, couleur)

    svg.pied()


def main():
    """
    on genere un svg kaleidoscopique a partir d'un nombre de triangles.
    """
    if len(sys.argv) != 2 or sys.argv[0] == "-h" or sys.argv[0] == "--help":
        print("utilisation:", sys.argv[0], "nombre_triangles > image.svg")
        sys.exit(1)

    nombre_triangles = int(sys.argv[1])

    generer_image(nombre_triangles)


if __name__ == "__main__":
    main()
