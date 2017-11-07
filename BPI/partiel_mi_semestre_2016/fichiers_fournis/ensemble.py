"""
Fournit une classe "EnsemblePoints" permettant de stocker
un ensemble de points a relier dans l'ordre pour les jeux de dessin
pour enfants.
"""


class EnsemblePoints:
    """
    ensemble de points a relier
    """
    def __init__(self, points):
        self.points = points

    def eliminer_doublons(self):
        """
        elimine les points consecutifs en double.
        exemple: [(0.0, 0.0), (1.0, 0.0), (1.0, 0.0), (2.0, 2.0), (0.0, 0.0)]
        devient [(0.0, 0.0), (1.0, 0.0), (2.0, 2.0)].
        """
        # TODO
        pass

    def coordonnees_max(self):
        """
        renvoie les couples (x, y) de coordonnees maximales.
        par exemple, pour [(0.0, 0.0), (1.0, 3.0), (2.0, 2.0)]
        renvoie (2.0, 3.0).
        """
        # TODO
        return 0.0, 0.0

    def simplification(self, nombre_points):
        """
        supprime des points jusqu'a ce qu'il ne reste plus que le
        nombre voulu.
        on considere pour chaque point le triplet qu'il forme
        avec son point precedant et son point suivant.
        chaque triplet forme un triangle d'une certaine aire.
        on elimine les points formant les plus petites aires.
        les points restants respectent l'ordre de depart.
        """
        # TODO
        pass

    def svg_vide(self, nom_fichier):
        """
        dessine les points a relier en svg (numerotes) dans le fichier donne.
        """
        # TODO
        pass

    def svg_traits(self, nom_fichier, nombre):
        """
        dessine les points a relier en svg (numerotes) dans le fichier donne.
        dessine egalement "nombre" traits, en partant du point 0.
        """
        # TODO
        pass


def lecture_ensemble(nom_fichier):
    """
    lit l'ensemble de points a partir d'un fichier (deux coordonnees par ligne)
    """
    with open(nom_fichier) as fichier:
        return EnsemblePoints([
            tuple([float(x) for x in ligne.split()])
            for ligne in fichier
        ])


def ensemble_test():
    """
    renvoie un ensemble contenant les trois points d'un petit triangle de test.
    """
    return EnsemblePoints([(10.0, 10.0), (300.0, 200.0), (150.0, 400.0)])
