"""
hashtable structure
"""
from geo.point import Point
from geo.segment import Segment

class Hash:
    """
    hash class
    """

def insert_into_table(tables, index, hash_key, point):
    """
    sub-function for hasher
    """
    if hash_key in tables[index].keys():
        tables[index].add(point)
    else:
        tables[index].update({hash_key : list(point)})

def hasher(points, precision):
    # on pouvait hasher un par un pour ne pas avoir à faire les 4 à chaque fois même dans le cas ou ce n'est pas nécessaire
    """
    hasher function
    """
    tables = list(dict() for _ in range(4))
    for point in points:
        hash_keys = list((point.coordinates[0]//precision,
                          point.coordinates[1]//precision),
                         ((point.coordinates[0]+(precision/2))//precision,
                          point.coordinates[1]//precision),
                         (point.coordinates[0]//precision,
                          (point.coordinates[1]+(precision/2))//precision),
                         ((point.coordinates[0]+(precision/2))//precision,
                          (point.coordinates[1]+(precision/2))//precision))
        for index in range(len(tables)):
            insert_into_table(tables, index, hash_keys[index], point)
    return tables

def has_collision(table):
    """
    return true if hash table given has collision, else false
    """
    for points in table.values():
        if len(points) > 1:
            return True
    return False

def ordered_segments(points):
    """
    iterator for ordered segments
    """
    precision = 0.5
    tables_groups = list(hasher(points, precision))
    while True: # pour simuler un do while
        collision = False
        for index in range(len(tables_groups[0])):
            if has_collision(tables_groups[-1][index]):
                collision = True
                break
        if collision:
            precision = precision/2
            # on pouvait faire en sorte de ne hasher que les tables qui possèdent une collision et pas les 4 toujours
            tables_groups.append(hasher(points, precision))
        else:
            break
    for tables in reversed(tables_groups):
        for table in tables:
            for key in table.keys():
                for points in table[key]:
                    if len(points) > 1:
                        for i in range(len(points)):
                            for j in range(i+1, len(points)):
                                yield Segment([points[i], points[j]])
