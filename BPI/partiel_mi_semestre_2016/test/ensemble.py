"""
Fournit une classe "EnsemblePoints" permettant de stocker
un ensemble de points a relier dans l'ordre pour les jeux de dessin
pour enfants.
"""
from iterateurs import cases, couples

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

        remove_first = False
        liste_removes = []
        iter_couples = couples(self.points)
        while True: # tant qu'on a pas fini d'itérer
            try:
                couple = next(iter_couples)
                remove_first = False
            except StopIteration:   # si on obtient dernier = premier, on laisse remove_first à True
                if remove_first:    # le catch empeche la mise à False si c'était True juste avant
                    liste_removes.pop() # on enlève le couple (dernier, premier)
                break
            else:
                if couple[0][0] == couple[1][0] and couple[0][1] == couple[1][1]:
                    liste_removes.append((couple[1][0], couple[1][1]))
                    remove_first = True
        for elem in liste_removes:
            self.points.remove(elem)
        if remove_first:
            del self.points[-1]

        # # méthode insuffisante car élimine le premier et non le dernier
        # # (dans le cas ou dernier = premier)
        # liste_removes = []
        # for point1, point2 in couples(self.points):
        #     if point1[0] == point2[0] and point1[1] == point2[1]:
        #         liste_removes.append((point1[0], point1[1]))
        # for elem in liste_removes:
        #     self.points.remove(elem)

    def coordonnees_max(self):
        """
        renvoie les couples (x, y) de coordonnees maximales.
        par exemple, pour [(0.0, 0.0), (1.0, 3.0), (2.0, 2.0)]
        renvoie (2.0, 3.0).
        """
        max_x = self.points[0][0]
        max_y = self.points[0][1]
        for coord_x, coord_y in zip(cases(self.points, 0), cases(self.points, 1)):
            if coord_x > max_x:
                max_x = coord_x
            if coord_y > max_y:
                max_y = coord_y
        return (max_x, max_y)

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
        with open(nom_fichier, "w") as fichier_svg:
            fichier_svg.write("<svg width=\"310.0\" height=\"410.0\"> \n")
            fichier_svg.write("<rect width=\"310.0\" height=\"410.0\" fill=\"white\"/> \n")
            for index, elem in enumerate(self.points):
                fichier_svg.write("<circle cx=\"" + str(elem[0]) + "\" cy=\"" + str(elem[1]) +
                                  "\" r=\"8\" fill=\"red\"/> \n")
                fichier_svg.write("<text x=\"" + str(elem[0]) + "\" y=\"" + str(elem[1]) +
                                  "\">" + str(index) + "</text> \n")
            fichier_svg.write("</svg>")

    def svg_traits(self, nom_fichier, nombre):
        """
        dessine les points a relier en svg (numerotes) dans le fichier donne.
        dessine egalement "nombre" traits, en partant du point 0.
        """
        # self.eliminer_doublons() # on élémine les doublonds au départ
        with open(nom_fichier, "w") as fichier_svg:
            fichier_svg.write("<svg width=\"1720.0\" height=\"870.0\"> \n")
            fichier_svg.write("<rect width=\"1720.0\" height=\"870.0\" fill=\"white\"/> \n")
            # on dessine d'abord les points
            # (on pouvait peut-être factoriser le code avec svg_vide())
            for index, elem in enumerate(self.points):
                fichier_svg.write("<circle cx=\"" + str(elem[0]) + "\" cy=\"" + str(elem[1]) +
                                  "\" r=\"8\" fill=\"red\"/> \n")
                fichier_svg.write("<text x=\"" + str(elem[0]) + "\" y=\"" + str(elem[1]) +
                                  "\">" + str(index) + "</text> \n")
            # on dessine ensuite les segments
            for elem in couples(self.points):
                if nombre == 0:
                    break
                fichier_svg.write("<line x1=\"" + str(elem[0][0]) + "\" y1=\"" + str(elem[0][1]) +
                                  "\" x2=\"" + str(elem[1][0]) + "\" y2=\"" + str(elem[1][1]) +
                                  "\" stroke=\"red\" stroke-width=\"8\"/> \n")
                nombre -= 1
            fichier_svg.write("</svg>")

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
