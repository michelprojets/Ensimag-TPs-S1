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
        for i in range(len(points)):
            related_components.add(points[i])
            for j in range(i):
                if linked(points[i], points[j]):
                    related_components.union(points[i], points[j])
                    break

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
        pass
