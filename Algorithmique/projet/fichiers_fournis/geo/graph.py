"""
graph structure
"""
from itertools import chain, combinations
from geo.quadrant import Quadrant
from geo.union import UnionFind
from geo.segment import Segment
from geo.hash import ordered_segments
from geo.tycat import tycat # pour le deboggage

class Graph:
    """
    create a graph from given set of segments.
    each endpoint is a vertex, each segment an edge.
    """
    def __init__(self, segments):
        self.vertices = dict()
        for segment in segments:
            for point in segment.endpoints:
                if point not in self.vertices:
                    self.vertices[point] = []
                self.vertices[point].append(segment)

    def bounding_quadrant(self):
        """
        return min quadrant containing underlying objects.
        """
        quadrant = Quadrant.empty_quadrant(2)
        for point in self.vertices:
            quadrant.add_point(point)
        return quadrant

    def svg_content(self):
        """
        svg for tycat.
        """
        edges = (e for (p, edges) in self.vertices.items() for e in edges if e.endpoints[0] == p)
        return "\n".join(c.svg_content() for c in chain(self.vertices.keys(), edges))


    def reconnect(self, hash_points):
        """
        greedily add edges until graph is fully connected.
        if hash_points is true then use hashed segments iterator
        else use quadratic segments iterator.
        """
        points = list(self.vertices.keys())
        related_components = UnionFind()

        def linked(vertice1, vertice2):
            """
            return true if both vertices are linked in the graph, else false
            """
            for segment1, segment2 in zip(self.vertices[vertice1], self.vertices[vertice2]):
                if (segment1.endpoint_not(vertice1) == vertice2 or
                        segment2.endpoint_not(vertice2) == vertice1):
                    return True
            return False

        # création de la structure modélisant les composantes connexes du graphe
        for i, point in enumerate(points):
            related_components.add(point)
            for j in range(i):
                if linked(points[i], points[j]):
                    related_components.union(points[i], points[j])
                    # # pas de break sinon créé une nouvelle composante connexe à chaque fois ?
                    # break

        if related_components.size == 1:
            return
        for segment in ordered_segments(hash_points, points):
            # si les deux points appatiennent à deux composantes différentes
            if (related_components.find(segment.endpoints[0]) !=
                    related_components.find(segment.endpoints[1])):
                # ajout du segment aux arêtes du graphe
                self.vertices[segment.endpoints[0]].append(segment)
                self.vertices[segment.endpoints[1]].append(segment)
                # fusion des deux composantes connexes
                related_components.union(segment.endpoints[0], segment.endpoints[1])
            if related_components.size == 1:
                return


    def even_degrees(self, hash_points):
        """
        greedily add edges until all degrees are even.
        if hash_points is true then use hashed segments iterator
        else use quadratic segments iterator.
        """
        points = list(self.vertices.keys())
        unevens = 0
        for vertice in points:
            if len(self.vertices[vertice])%2 != 0:
                unevens += 1
        if unevens == 0:
            return
        for segment in ordered_segments(hash_points, points):
            if (len(self.vertices[segment.endpoints[0]])%2 != 0 and
                    len(self.vertices[segment.endpoints[0]])%2 != 0):
                # ajout du segment aux arêtes du graphe
                self.vertices[segment.endpoints[0]].append(segment)
                self.vertices[segment.endpoints[1]].append(segment)
                unevens -= 2
                if unevens == 0:
                    return



    def eulerian_cycle(self):
        """
        return eulerian cycle. precondition: all degrees are even.
        """
        # tous les cycles (chaque cycle contient une liste de points)
        cycles = list()
        unseen_segments = list()
        for segments in self.vertices.values():
            # unseen_segments va posséder des doublons pour chaque segment (à remove)
            unseen_segments.extend(segments)

        while len(unseen_segments) != 0:
            cycles.append(list())
            segment = unseen_segments[0]
            unseen_segments.remove(segment)
            unseen_segments.remove(Segment([segment.endpoints[1], segment.endpoints[0]]))   # ne marche pas
            cycles[-1].append(segment.endpoints[0])
            last_point = segment.endpoints[1]
            # tant que le dernier chemin n'a pas formé un cycle (dernier point != premier point)
            while last_point != cycles[-1][0]:
                # on prend vertices[last_point][0] car on prend un chemin quelconque
                any_point = self.vertices[last_point][0].endpoint_not(last_point)
                cycles[-1].append(any_point)
                unseen_segments.remove(Segment([last_point, any_point]))    # ne marche pas
                unseen_segments.remove(Segment([any_point, last_point]))    # ne marche pas
                last_point = cycles[-1][-1]

        # fusion de tous les cycles précédents
        # ici, le cycle eulérien (qui passe par tous les sommets) contient une liste de segments
        # euler_cycle = list(Segment([cycles[0][0], cycles[0][1]]))
        # for cycle in cycles:
        #     for point in cycle:
        #
