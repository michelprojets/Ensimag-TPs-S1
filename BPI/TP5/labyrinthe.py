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
    # cas d'arret
    if ((rectangle.point_2.coord_x - rectangle.point_1.coord_x)/CASE == 1 or
            (rectangle.point_3.coord_y - rectangle.point_1.coord_y)/CASE == 1):
        return
    # cas récursif
    else:
        # soit on va faire un mur horizontal, soit un mur vertical
        # if (rectangle.point_2.coord_x - rectangle.point_1.coord_x)/CASE == 1:
        #     # on va faire que des murs horizontaux
        #     alea = 0
        #     point_mur_y = randint((rectangle.point_1.coord_y/CASE)+1,
        #                           (rectangle.point_3.coord_y/CASE)-1)*CASE
        #     point_porte_x = randint((rectangle.point_1.coord_x/CASE),
        #                             (rectangle.point_2.coord_x/CASE)-1)*CASE
        # elif (rectangle.point_3.coord_y - rectangle.point_1.coord_y)/CASE == 1:
        #     # on va faire que des murs verticaux
        #     alea = 1
        #     point_mur_x = randint((rectangle.point_1.coord_x/CASE)+1,
        #                           (rectangle.point_2.coord_x/CASE)-1)*CASE
        #     point_porte_y = randint((rectangle.point_1.coord_y/CASE),
        #                             (rectangle.point_3.coord_y/CASE)-1)*CASE
        # else: # cas général
        alea = randint(0, 1)
        point_mur_y = randint((rectangle.point_1.coord_y/CASE)+1,
                              (rectangle.point_3.coord_y/CASE)-1)*CASE
        point_porte_x = randint((rectangle.point_1.coord_x/CASE),
                                (rectangle.point_2.coord_x/CASE)-1)*CASE
        point_mur_x = randint((rectangle.point_1.coord_x/CASE)+1,
                              (rectangle.point_2.coord_x/CASE)-1)*CASE
        point_porte_y = randint((rectangle.point_1.coord_y/CASE),
                                (rectangle.point_3.coord_y/CASE)-1)*CASE

        if alea == 0: # mur horizontal avec une seule porte
            print("<line x1=\"" + str(rectangle.point_1.coord_x) + "\" y1=\"" + str(point_mur_y) +
                  "\" x2=\"" + str(point_porte_x) + "\" y2=\"" + str(point_mur_y) +
                  "\" style=\"stroke:rgb(0,0,0);stroke-width:2\"/>")
            print("<line x1=\"" + str(point_porte_x+CASE) + "\" y1=\"" + str(point_mur_y) +
                  "\" x2=\"" + str(rectangle.point_2.coord_x) + "\" y2=\"" + str(point_mur_y) +
                  "\" style=\"stroke:rgb(0,0,0);stroke-width:2\"/>")
            rectangle_1 = Rectangle(Point(rectangle.point_1.coord_x, rectangle.point_1.coord_y),
                                    Point(rectangle.point_2.coord_x, rectangle.point_2.coord_y),
                                    Point(rectangle.point_3.coord_x, point_mur_y),
                                    Point(rectangle.point_4.coord_x, point_mur_y))
            rectangle_2 = Rectangle(Point(rectangle.point_1.coord_x, point_mur_y),
                                    Point(rectangle.point_2.coord_x, point_mur_y),
                                    Point(rectangle.point_3.coord_x, rectangle.point_3.coord_y),
                                    Point(rectangle.point_4.coord_x, rectangle.point_4.coord_y))
        else: # mur vertical avec une seule porte
            print("<line x1=\"" + str(point_mur_x) + "\" y1=\"" + str(rectangle.point_1.coord_y) +
                  "\" x2=\"" + str(point_mur_x) + "\" y2=\"" + str(point_porte_y) +
                  "\" style=\"stroke:rgb(0,0,0);stroke-width:2\"/>")
            print("<line x1=\"" + str(point_mur_x) + "\" y1=\"" + str(point_porte_y+CASE) +
                  "\" x2=\"" + str(point_mur_x) + "\" y2=\"" + str(rectangle.point_3.coord_y) +
                  "\" style=\"stroke:rgb(0,0,0);stroke-width:2\"/>")
            rectangle_1 = Rectangle(Point(rectangle.point_1.coord_x, rectangle.point_1.coord_y),
                                    Point(point_mur_x, rectangle.point_2.coord_y),
                                    Point(rectangle.point_3.coord_x, rectangle.point_3.coord_y),
                                    Point(point_mur_x, rectangle.point_4.coord_y))
            rectangle_2 = Rectangle(Point(point_mur_x, rectangle.point_1.coord_y),
                                    Point(rectangle.point_2.coord_x, rectangle.point_2.coord_y),
                                    Point(point_mur_x, rectangle.point_3.coord_y),
                                    Point(rectangle.point_4.coord_x, rectangle.point_4.coord_y))
        labyrinthe(rectangle_1)
        labyrinthe(rectangle_2)
def main():
    """
    programme principal
    """
    # cas initial (on trace les contours du labyrinthe avec l'entrée et la sortie)
    print("<svg width=\"" + str(LARGEUR) + "\" height=\"" + str(HAUTEUR) + "\">")
    print("<rect width=\"" + str(LARGEUR) + "\" height=\"" + str(HAUTEUR) + "\" fill=\"white\"/>")
    print("<line x1=\"" + str(CASE) + "\" y1=\"0\" x2=\"" + str(LARGEUR) + "\" y2=\"0\" " +
          "style=\"stroke:rgb(0,0,255);stroke-width:2\"/>")
    print("<line x1=\"0\" y1=\"0\" x2=\"0\" y2=\"" + str(HAUTEUR) + "\" " +
          "style=\"stroke:rgb(0,0,255);stroke-width:2\"/>")
    print("<line x1=\"" + str(LARGEUR) + "\" y1=\"0\" x2=\"" + str(LARGEUR) + "\" y2=\" " +
          str(HAUTEUR) + "\" style=\"stroke:rgb(0,0,255);stroke-width:2\"/>")
    print("<line x1=\"0\" y1=\"" + str(HAUTEUR) + "\" x2=\"" + str(LARGEUR-CASE) + "\" y2=\"" +
          str(HAUTEUR) + "\" style=\"stroke:rgb(0,0,255);stroke-width:2\"/>")
    labyrinthe(Rectangle(Point(0, 0), Point(LARGEUR, 0), Point(0, HAUTEUR),
                         Point(LARGEUR, HAUTEUR)))
    print("</svg>")

if __name__ == "__main__":
    main()
