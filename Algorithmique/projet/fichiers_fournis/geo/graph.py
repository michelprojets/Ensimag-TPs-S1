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
            # ici on ne vérifie pas si le segment est déjà dans le graphe avant
            # de l'ajouter donc une arête peut apparaître plusieurs fois (multi-graphe)
            if ((len(self.vertices[segment.endpoints[0]])%2 != 0) and
                    (len(self.vertices[segment.endpoints[1]])%2 != 0)):
                # ajout du segment aux arêtes du graphe
                self.vertices[segment.endpoints[0]].append(segment)
                self.vertices[segment.endpoints[1]].append(segment)
                unevens -= 2
                if unevens == 0:
                    break


    def eulerian_cycle(self):
        """
        return eulerian cycle. precondition: all degrees are even.
        """

        # # les segments non vus sont stockés dans un dictionnaire {segment : compteur de doublons}
        # # avec segment qui est un couple de 2 points
        # unseen_segments = dict()
        # for segments in self.vertices.values():
        #     for segment in segments:
        #         # il se peut qu'on ait (à cause de l'itérateur) les segments [A,B] et [B,A] qui
        #         # sont en réalité identiques (auquel cas on doit incrémenter le compteur)
        #         new_seg1 = (segment.endpoints[0], segment.endpoints[1])
        #         new_seg2 = (segment.endpoints[1], segment.endpoints[0])
        #         if new_seg1 in unseen_segments:
        #             unseen_segments[new_seg1] += 1
        #         elif new_seg2 in unseen_segments:
        #             unseen_segments[new_seg2] += 1
        #         else:
        #             unseen_segments.update({new_seg1 : 1})
        #
        # # comme chaque segment a été compté 2 fois, on divise tout par 2
        # for segment in unseen_segments.keys():
        #     unseen_segments[segment] /= 2
        #
        # # tous les cycles (chaque cycle contient une liste de segments qui sont
        # # des couples de 2 points ici)
        # cycles = list()
        # while len(unseen_segments) != 0:
        #     cycles.append(list())
        #     # segment de départ arbitraire donné par la méthode popitem() de python
        #     item = unseen_segments.popitem()
        #     # si l'arête est répété plusieurs fois dans le graphe
        #     # on le remet dedans en décrémentant le compteur de doublons
        #     if item[1] > 1:
        #         unseen_segments.update({item[0] : item[1]-1})
        #     segment = item[0]
        #     cycles[-1].append(Segment([segment[0], segment[1]]))
        #     last_point = segment[1]
        #     # tant que le dernier chemin n'a pas formé un cycle
        #     # (si on respecte la précondition et si on avance dans n'importe quelle direction,
        #     # on revient toujours au point de départ, donc s'assure que la boucle va se terminer
        #     # dans tous les cas)
        #     while last_point != segment[0]:
        #         # on prend vertices[last_point][0] car on prend un chemin quelconque
        #         any_point = self.vertices[last_point][0].endpoint_not(last_point)
        #         new_seg1 = Segment([last_point, any_point])
        #         new_seg2 = Segment([any_point, last_point])
        #         cycles[-1].append(new_seg1)
        #         # on supprime le segment pour le marquer comme vu
        #         if new_seg1 in unseen_segments:
        #             if unseen_segments[new_seg1] > 1:
        #                 unseen_segments[new_seg1] -= 1
        #         elif new_seg2 in unseen_segments:
        #             if unseen_segments[new_seg2] > 1:
        #                 unseen_segments[new_seg2] -= 1
        #         else:
        #             # unseen_segments contient soit l'un soit l'autre
        #             unseen_segments.pop((last_point, any_point), None)
        #             unseen_segments.pop((any_point, last_point), None)
        #         last_point = any_point
        #
        # def common_segment(current, current_cycle, cycles):
        #     """
        #     return the index (0) of the first segment in the cycle and the index (1) of the cycle
        #     associated if the current given segment has been found in another cycle, else None
        #     """
        #     if cycles is None:
        #         return None
        #     if len(cycles) == 0:
        #         return None
        #     for cycle_index, cycle in cycles:
        #         if cycle_index != current_cycle:
        #             for seg_index, segment in enumerate(cycle):
        #                 if ((current.endpoints[0] == segment.endpoints[0] and
        #                      current.endpoints[1] == segment.endpoints[1]) or
        #                         (current.endpoints[0] == segment.endpoints[1] and
        #                          current.endpoints[1] == segment.endpoints[0])):
        #                     return (seg_index, cycle_index)
        #     return None
        #
        # # fusion de tous les cycles précédents
        # euler_cycle = list(cycles[0][0])
        # # index of current segment and current cycle in cycles list
        # current_segment = 0
        # current_cycle = 0
        # while len(cycles) != 0:
        #     current = cycles[current_cycle].pop(current_segment)
        #     if len(cycles[current_cycle]) == 0:
        #         cycles.pop(current_cycle)
        #     euler_cycle.append(current)
        #     seg_cycle = common_segment(current, current_cycle, cycles)
        #     if seg_cycle is not None:
        #         current_segment = (seg_cycle[0]+1)%len(cycles[seg_cycle[1]])
        #         current_cycle = seg_cycle[1]
        #
        # return euler_cycle
        return None
