#! /usr/bin/env python3
"""
module contenant la classe point
"""

class Point:
    """
    classe point
    """

    def __init__(self, coord_x_y):
        """
        constructeur de la classe
        """
        self.coord_x_y = coord_x_y

    def set_coords(self, coord_x_y):
        """
        méthode qui modifie les coordonnées d'un point
        """
        self.coord_x_y = coord_x_y
