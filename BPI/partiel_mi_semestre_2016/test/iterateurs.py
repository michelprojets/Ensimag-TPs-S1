#!/usr/bin/env python3
"""
fichier contenant tous les iterateurs
"""

def cases(iterable, index):
    """
    renvoie un itérateur qui itère sur chaque élément à l'index
    spécifié de chaque élément de l'itérable passé en paramètre
    """
    for elem in iterable:
        yield elem[index]

def couples(iterable):
    """
    renvoie un itérateur qui itère sur chaque couple d'éléments
    successifs de l'itérable passé en paramètre
    """
    if len(iterable) <= 1:
        return
    prec = iterable[0]
    premier = prec  # tuple est non mutable donc pas de partage de référence
    for index, elem in enumerate(iterable):
        if index != 0:  # pour sauter le premier cas
            yield (prec, elem)
            prec = elem
    yield (prec, premier)
