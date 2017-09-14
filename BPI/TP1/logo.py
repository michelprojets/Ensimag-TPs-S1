"""
le module implemente les primitives graphiques basiques
d'une tortue logo.
"""

from math import cos, sin, pi

class Logo:
    """
    une tortue logo, positionnee dans le plan.
    """
    def __init__(self):
        """
        positionne la tortue a l'origine, demarre le svg
        """
        self.abscisse = 0.0
        self.ordonnee = 0.0
        self.direction = 270.0  # angle du regard de la tortue (en degre)
        self.crayon_en_bas = False
        # en tete du fichier svg
        print("<svg width=\"100\" height=\"100\">")

    def avance(self, distance):
        """
        avance la tortue tout droit de la distance donnee
        """
        # on calcule les nouvelles coordonnees de la tortue
        new_abscisse = self.abscisse + distance * cos(self.direction * pi / 180)
        new_ordonnee = self.ordonnee + distance * sin(self.direction * pi / 180)
        # si le crayon est en bas, la tortue dessine
        if self.crayon_en_bas:
            print("<line x1=\"" + str(self.abscisse) + "\" " + "y1=\"" + str(self.ordonnee) +
                  "\" " + "x2=\"" + str(new_abscisse) + "\" " + "y2=\"" + str(new_ordonnee) +
                  "\" " + "style=\"stroke:rgb(255,0,0);stroke-width:2\"/>")
        # on met a jour la nouvelle position de la tortue
        self.abscisse = new_abscisse
        self.ordonnee = new_ordonnee

    def tourne_droite(self, angle):
        """
        change la direction de la tortue en tournant a droite
        de l'angle donne (en degre)
        """
        self.direction += angle
        self.direction %= 360.0

    def tourne_gauche(self, angle):
        """
        change la direction de la tortue en tournant a gauche
        de l'angle donne (en degre)
        """
        self.direction -= angle
        if self.direction < 0.0:
            self.direction += 360

    def baisse_crayon(self):
        """
        baisse le crayon. a partir de maintenant la tortue dessine
        lorsqu'elle avance
        """
        self.crayon_en_bas = True

    def leve_crayon(self):
        """
        leve le crayon. a partir de maintenant la tortue ne dessine pas
        lorsqu'elle avance.
        """
        self.crayon_en_bas = False

    def __del__(self):
        """
        destructeur, termine le fichier svg
        """
        print("</svg>")
