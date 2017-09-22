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
    # print("<polygon points=\"" + str(triangle.point_1.coord_x_y[0]), + "," +
    #       str(triangle.point_1.coord_x_y[1]) + " " +
    #       str(triangle.point_2.coord_x_y[0]) + "," +
    #       str(triangle.point_2.coord_x_y[1]) + " " +
    #       str(triangle.point_3.coord_x_y[0]) + "," +
    #       str(triangle.point_3.coord_x_y[1]) + "\" style=\"fill:" +
    #       couleur + ";stroke-width=\"0\" />")
    print("<polygon points=\"" + str(triangle.point_1.coord_x_y[0]), + ",")
    print(str(triangle.point_1.coord_x_y[1]) + " ")
    print(str(triangle.point_2.coord_x_y[0]) + ",")
    print(str(triangle.point_2.coord_x_y[1]) + " ")
    print(str(triangle.point_3.coord_x_y[0]) + ",")
    print(str(triangle.point_3.coord_x_y[1]) + "\" style=\"fill:")
    print(couleur + ";stroke-width=\"0\" />")

def couleur_aleatoire():
    """
    fonction qui renvoie une couleur aléatoire en svg
    """
    return "rgb(" + str(randint(0, 255)) + "," + str(randint(0, 255)) + \
           "," + str(randint(0, 255)) + ")"

def pied():
    """
    fonction qui affiche sur la sortie standard le pied svg
    """
    print("</svg>")
