#! /usr/bin/env python3
"""
module sapiniser
"""

import sys
import struct
from math import fabs, sin

class Triangle:
    """
    classe Triangle
    """
    def __init__(self, vect_norm, sommets):
        """
        construuteur d'un Triangle
        """
        self.vect_norm = vect_norm
        self.sommets = sommets

    def __str__(self):
        return ("(" + str(self.vect_norm) + ", " + str([str(sommet) for sommet in self.sommets])
                + ")" + "\n")

class Point:
    """
    classe Point
    """
    def __init__(self, coord_x=0, coord_y=0, coord_z=0):
        """
        constructeur d'un Point
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
        addition de chaque coordonnées du point
        """
        self.set_coords(self.coord_x + point_2.coord_x, self.coord_y + point_2.coord_y,
                        self.coord_z + point_2.coord_z)

    def __sub__(self, point_2):
        """
        override de la méthode __sub__ '-'
        soustraction de chaque coordonnées du point
        """
        self.set_coords(self.coord_x - point_2.coord_x, self.coord_y - point_2.coord_y,
                        self.coord_z - point_2.coord_z)

    def __str__(self):
        """
        méthode tostring
        """
        return "(" + str(self.coord_x) + ", " + str(self.coord_y) + ", " + str(self.coord_z) + ")"

def moyenne_points(triangle):
    """
    fonction qui calcul et qui retourne un centre approximatif (moyenne des points) du triangle
    """
    return Point((triangle.sommets[0].coord_x + triangle.sommets[1].coord_x +
                  triangle.sommets[2].coord_x)/3,
                 (triangle.sommets[0].coord_y + triangle.sommets[1].coord_y +
                  triangle.sommets[2].coord_y)/3,
                 (triangle.sommets[0].coord_z + triangle.sommets[1].coord_z +
                  triangle.sommets[2].coord_z)/3)

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

def sapinisation(triangles):
    """
    fonction qui va pour chaque point des triangles calcule le point de sapinisation associé
    """
    for triangle in triangles:
        centre = moyenne_points(triangle)
        for sommet in triangle.sommets:
            facteur = facteur_aggrandissement(sommet.coord_z)
            _ = sommet - centre
            fonction_aggrandissement(sommet, facteur)
            _ = sommet + centre

def lecture_fichier(fichier_stl):
    """
    lit un fichier stl, enregistre les triangles et retourne la liste des triangles
    """
    triangles = list()

    with open(fichier_stl, "rb") as fichier_bin:
        strct = struct.Struct("<l")
        _ = fichier_bin.read(80)
        nb_triangles = strct.unpack(fichier_bin.read(4))[0]
        for _ in range(nb_triangles):
            vect_norm = Point(strct.unpack(fichier_bin.read(4))[0],
                              strct.unpack(fichier_bin.read(4))[0],
                              strct.unpack(fichier_bin.read(4))[0])
            sommet_1 = Point(strct.unpack(fichier_bin.read(4))[0],
                             strct.unpack(fichier_bin.read(4))[0],
                             strct.unpack(fichier_bin.read(4))[0])
            sommet_2 = Point(strct.unpack(fichier_bin.read(4))[0],
                             strct.unpack(fichier_bin.read(4))[0],
                             strct.unpack(fichier_bin.read(4))[0])
            sommet_3 = Point(strct.unpack(fichier_bin.read(4))[0],
                             strct.unpack(fichier_bin.read(4))[0],
                             strct.unpack(fichier_bin.read(4))[0])
            _ = struct.unpack("<h", fichier_bin.read(2))
            triangles.append(Triangle(vect_norm, [sommet_1, sommet_2, sommet_3]))
    return triangles

def ecriture_fichier(fichier_stl, triangles):
    """
    écrit dans un fichier stl les triangles (tous les points) préalablements modifiés
    """
    strct = struct.Struct("<l")
    entete = bin(0)

    with open(fichier_stl, "rb") as fichier_bin:
        entete = fichier_bin.read(80)
        _ = strct.unpack(fichier_bin.read(4))

    with open(fichier_stl, "wb") as fichier_bin:
        fichier_bin.write(entete)
        for triangle in triangles:
            for sommet in triangle.sommets:
                fichier_bin.write(strct.pack(sommet.coord_x))
                fichier_bin.write(strct.pack(sommet.coord_y))
                fichier_bin.write(strct.pack(sommet.coord_z))
            fichier_bin.write(struct.pack("<h", 0))

def main():
    """
    programme principal
    """
    if len(sys.argv) != 2 or sys.argv[0] == "-h" or sys.argv[0] == "--help":
        print("utilisation : ", sys.argv[0], "fichier.stl")
        sys.exit(1)

    nom_fichier_stl = sys.argv[1]
    # enregistrement des triangles à partir du fichier stl
    triangles = lecture_fichier(nom_fichier_stl)
    # modification des triangles (tous les points)
    sapinisation(triangles)
    # # test
    # for triangle in triangles:
    #     print(triangle)
    # écriture des triangles (tous les points) modifiés dans le fichier stl
    ecriture_fichier(nom_fichier_stl, triangles)

if __name__ == "__main__":
    main()
