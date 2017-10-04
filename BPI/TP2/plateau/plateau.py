#! /usr/bin/env python3

"""
module principal : plateau
"""
import sys
import svg
from point import Point

def iter_case(largeur, hauteur):
    """
    itérateur qui donne les coordonnées du point en bas à gauche du carré à tracer
    """
    point_bas_gauche_case = Point((0, 0))
    abscisse = 0
    ordonnee = hauteur
    gauche_a_droite = True  # sens des cases
    while ordonnee >= 0: # tant qu'on ne dépasse pas la limite de la hauteur
        if gauche_a_droite: # gauche à droite
            for abscisse in range(0, largeur, 40):
                point_bas_gauche_case.set_coords([abscisse, ordonnee])
                yield point_bas_gauche_case
                # s'il arrive tout à droite
                if point_bas_gauche_case.coord_x_y[0] == largeur-40:
                    if ordonnee >= 0: # si on ne dépasse pas la limite de la hauteur
                        ordonnee -= 40
                        point_bas_gauche_case.set_coords([abscisse, ordonnee])
                        yield point_bas_gauche_case
                        gauche_a_droite = False
                        #break   # on sort du for
        else:       # droite à gauche
            for abscisse in range(largeur-40, -40, -40):
                point_bas_gauche_case.set_coords([abscisse, ordonnee])
                yield point_bas_gauche_case
                # s'il arrive tout à droite
                if point_bas_gauche_case.coord_x_y[0] == 0:
                    if ordonnee >= 0:  # si on ne dépasse pas la limite de la hauteur
                        ordonnee -= 40
                        point_bas_gauche_case.set_coords([abscisse, ordonnee])
                        yield point_bas_gauche_case
                        gauche_a_droite = True
                        #break   # on sort du for
        ordonnee -= 40

def generer_image(largeur, hauteur):
    """
    fonction qui génère l'image svg correspondant au plateau
    """
    svg.entete(largeur, hauteur)
    for coord_bas_gauche_case in iter_case(largeur, hauteur):
        svg.affiche_case_40x40(coord_bas_gauche_case)
    svg.pied()

def main():
    """
    programme principal
    """
    if len(sys.argv) != 3 or sys.argv[0] == "-h" or sys.argv[0] == "--help":
        print("utilisation:", sys.argv[0], "largeur hauteur > image.svg")
        sys.exit(1)

    largeur = int(sys.argv[1])
    hauteur = int(sys.argv[2])

    generer_image(largeur, hauteur)


if __name__ == "__main__":
    main()
