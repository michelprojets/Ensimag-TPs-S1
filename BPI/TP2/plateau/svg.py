#¡/usr/bin/env python3
"""
module svg
"""
from random import randint

def entete(largeur, hauteur):
    """
    fonction qui affiche sur la sortie standard l'entête svg
    """
    print("<svg width=\"" + str(largeur) + "\" height=\"" +
          str(hauteur) + "\">")

def affiche_triangle(triangle, couleur):
    """
    fonction qui affiche sur la sortie standard un triangle
    """
    print("<polygon points=\"" + str(triangle.point_1.coord_x_y[0]) + "," +
          str(triangle.point_1.coord_x_y[1]) + " " +
          str(triangle.point_2.coord_x_y[0]) + "," +
          str(triangle.point_2.coord_x_y[1]) + " " +
          str(triangle.point_3.coord_x_y[0]) + "," +
          str(triangle.point_3.coord_x_y[1]) + "\" style=\"fill:" +
          couleur + ";stroke-width=0\"/>")

def couleur_aleatoire():
    """
    fonction qui renvoie une couleur aléatoire en svg
    """
    return "rgb(" + str(randint(0, 255)) + "," + str(randint(0, 255)) + \
           "," + str(randint(0, 255)) + ")"

def affiche_case_40x40(point_bas_gauche_case):
    """
    fonction qui affiche sur la sortie standart une case de dimension 40x40
    """
    print("<polygon points=\"" + str(point_bas_gauche_case.coord_x_y[0]) + "," +
          str(point_bas_gauche_case.coord_x_y[1]) + " " +
          str(point_bas_gauche_case.coord_x_y[0] + 40) + "," +
          str(point_bas_gauche_case.coord_x_y[1]) + " " +
          str(point_bas_gauche_case.coord_x_y[0] + 40) + "," +
          str(point_bas_gauche_case.coord_x_y[1] - 40) + " " +
          str(point_bas_gauche_case.coord_x_y[0]) + "," +
          str(point_bas_gauche_case.coord_x_y[1] - 40) +
          "\" style=\"fill:white;stroke:black;stroke-width:1\"/>")

def pied():
    """
    fonction qui affiche sur la sortie standard le pied svg
    """
    print("</svg>")
