#! /usr/bin/env python3
"""
module principal
"""

def pivote(tableau, indice_pivot):
    """
    fonction pivote qui retourne deux tableaux :
    l'un contenant les éléments inférieurs au pivot
    l'autre contenant les éléments strictement supérieurs au pivot
    """
    tab_inf_eg = []
    tab_sup = []
    pivot = tableau[indice_pivot]
    for indice, elem in enumerate(tableau):
        if indice != indice_pivot:
            if elem <= pivot:
                tab_inf_eg.append(elem)
            else:
                tab_sup.append(elem)
    return (tab_inf_eg, tab_sup)

def pivote_enplace(tableau, indice_pivot):
    """
    fonction qui retourne un tableau dont les éléments inférieurs au pivot
    sont "à gauche" du pivot et les éléments strictement supérieurs au pivot
    sont "à droite" du pivot
    """
    pivot = tableau[indice_pivot]
    for i, elem in enumerate(tableau):
        if indice_pivot > i and elem >= pivot:
            for j in range(indice_pivot, len(tableau)):
                if tableau[j] <= pivot:
                    (tableau[i], tableau[j]) = (tableau[j], tableau[i])   # permutation
        elif indice_pivot < i and elem <= pivot:
            for j in range(indice_pivot + 1):
                if tableau[j] > pivot:
                    (tableau[i], tableau[j]) = (tableau[j], tableau[i])   # permutation
    return tableau
    
def main():
    """
    programme principal
    """
    tab = [3, 0, 10, 1, 6, 9, 5, 3, 9, 0, 5, 8, 9, 8, 4, 2, 0, 9, 6, 2]
    print("pivot :", tab[7], "indice : 7")
    #print(pivote(tab, 7))
    print(pivote_enplace(tab, 7))

main()
