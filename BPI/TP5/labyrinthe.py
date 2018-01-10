#! /usr/bin/env python3
"""
module labyrinthe
"""
from random import randint
from point import Point

LARGEUR = 500
HAUTEUR = 500
CASE = 10

class Rectangle():
    """
    classe rectangle
    """
    def __init__(self, point_1, point_2, point_3, point_4):
        """
        constructeur
        """
        self.point_1 = point_1
        self.point_2 = point_2
        self.point_3 = point_3
        self.point_4 = point_4

def labyrinthe(rectangle):
    """
    génère récursivement un labyrinthe
    """
    point_rand_1 = Point(randint(rectangle.point_1.coord_x, rectangle.point_2.coord_x),
                         rectangle.point_1.coord_y)
    point_rand_2 = Point(point_rand_1.coord_x, randint(rectangle.point_2.coord_y,
                         rectangle.point_4.coord_y))

def main():
    """
    programme principal
    """
    # cas initial
    print("<svg width=\"" + str(LARGEUR) + "\" height=\"" + str(HAUTEUR) + "\">")
    print("<rect width=\"" + str(LARGEUR) + "\" height=\"" + str(HAUTEUR) + "\" fill=\"white\"/>")
    print("<line x1=\"" + str(CASE) + "\" y1=\"0\" x2=\"" + str(LARGEUR) + "\" y2=\"0\" " +
          "style=\"stroke:rgb(0,0,0);stroke-width:2\"/>")
    print("<line x1=\"0\" y1=\"0\" x2=\"0\" y2=\"" + str(HAUTEUR) + "\" " +
          "style=\"stroke:rgb(0,0,0);stroke-width:2\"/>")
    print("<line x1=\"" + str(LARGEUR) + "\" y1=\"0\" x2=\"" + str(LARGEUR) + "\" y2=\" " +
          str(HAUTEUR) + "\" style=\"stroke:rgb(0,0,0);stroke-width:2\"/>")
    print("<line x1=\"0\" y1=\"" + str(HAUTEUR) + "\" x2=\"" + str(LARGEUR-CASE) + "\" y2=\"" +
          str(HAUTEUR) + "\" style=\"stroke:rgb(0,0,0);stroke-width:2\"/>")
    labyrinthe(Rectangle(Point(0, 0), Point(LARGEUR, 0), Point(0, HAUTEUR),
               Point(LARGEUR, HAUTEUR)))
    print("</svg>")

if __name__ == "__main__":
    main()
