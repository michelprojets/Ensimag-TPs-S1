"""
hashtable structure
"""
from itertools import combinations
from geo.point import Point
from geo.segment import Segment

class Hash:
    """
    hash class
    """

    def __init__(self, points, precision):
        """
        constructor
        """
        self.tables = list(dict() for _ in range(4))
        # on hash directement lors de l'initialisation
        self.hasher(points, precision)

    def hasher(self, points, precision):
        # on pouvait hasher un par un pour ne pas avoir à faire les 4 à chaque
        # fois même dans le cas ou ce n'est pas nécessaire
        """
        hasher function
        """
        def insert_into_table(index, hash_key, point):
            """
            sub-function for hasher
            """
            if hash_key not in self.tables[index]:
                self.tables[index][hash_key] = []
            self.tables[index][hash_key].append(point)

        for point in points:
            # les 4 fonctions de hashage directement appliquées
            hash_keys = [(point.coordinates[0]//precision,
                          point.coordinates[1]//precision),
                         ((point.coordinates[0]+(precision/2))//precision,
                          point.coordinates[1]//precision),
                         (point.coordinates[0]//precision,
                          (point.coordinates[1]+(precision/2))//precision),
                         ((point.coordinates[0]+(precision/2))//precision,
                          (point.coordinates[1]+(precision/2))//precision)]
            for index in range(len(self.tables)):
                insert_into_table(index, hash_keys[index], point)

    def has_collision(self, index):
        """
        return true if hash table corresponding to the index given has collision, else false
        """
        for points in self.tables[index].values():
            if len(points) > 1:
                return True
        return False

def ordered_segments(hash_points, points):
    """
    iterator for ordered segments
    """
    def segment_length(points):
        """
        return the length of the given segment (couple of two points)
        """
        return points[0].distance_to(points[1])

    # avec hashage
    if hash_points:
        precision = 100.0 # valeur arbitraire
        tables_groups = [Hash(points, precision)]
        while True: # pour simuler un do while
            collision = False
            for index in range(len(tables_groups[0].tables)):
                # "-1" car dernier jeu de tables
                if tables_groups[-1].has_collision(index):
                    collision = True
                    break
            if collision:
                precision = precision/2
                # on pouvait faire en sorte de ne hasher que les tables
                # qui possèdent une collision et pas les 4 toujours
                tables_groups.append(Hash(points, precision))
            else:
                break
        # inversion de la liste des jeux de tables
        tables_groups = iter(reversed(tables_groups))
        # pour éviter d'itérer dans le jeu de table le plus précis car pas de combinaisons
        next(tables_groups)
        # pour éviter de proposer des doublons de segment (représenté par un couple de 2 points ici)
        # on considère également ici que le segment [a,b] est un doublon du segment [b,a]
        seen_segments = set()
        for hash_tables in tables_groups:
            for hash_table in hash_tables.tables:
                for hash_points in hash_table.values():
                    if len(hash_points) > 1:
                        # toutes les combinaisons de points
                        for point1, point2 in combinations(hash_points, 2):
                            # on va payer plus cher dans cet itérateur à tester l'appartenance
                            # mais moins cher dans les fonctions du graphe car on va éviter
                            # des parcours inutiles
                            if ((point1, point2) not in seen_segments and
                                    (point2, point1) not in seen_segments):
                                seen_segments.add((point1, point2))
                                seen_segments.add((point2, point1))
                                yield Segment([point1, point2])
    # sans hachage (itérateur quadratique)
    else:
        for point1, point2 in sorted(combinations(points, 2), key=segment_length):
            yield Segment([point1, point2])
