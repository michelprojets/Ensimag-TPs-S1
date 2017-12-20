#! /usr/bin/env python3
"""
module contenant la classe point
"""

class Point:
    """
    classe point
    """

    def __init__(self, coord_x=0, coord_y=0):
        """
        constructeur
        """
        self.coord_x = coord_x
        self.coord_y = coord_y

    def set_coords(self, coord_x, coord_y):
        """
        méthode qui modifie les coordonnées d'un point
        """
        self.coord_x = coord_x
        self.coord_y = coord_y

    def draw_svg(self):
        """
        méthode qui renvoie le point sous le format svg
        """
        return ("<circle cx=\"" + str(self.coord_x) + "\" cy=\"" +
                str(self.coord_y) + "\" r=\"2\" stroke=\"black\"" +
                " stroke-width=\"1\" fill=\"black\" />")
