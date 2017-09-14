#! /usr/bin/env python3
"""
module principal
"""
from random import randint
# from bonjour import dire_bonjour
# from age import calcul_age_2050
from point import Point
from svg import creer_triangle_fichier_svg
def entree():
    """
    demande à l'ulisateur de saisir une information en la récupérant sous forme d'un entier
    """
    print("saisissez un entier")
    return int(input())
def main():
    """
    programme principal
    """
    # # bonjour
    # print(dire_bonjour())
    # # age
    # print("quel est votre age ?")
    # print("vous allez avoir", calcul_age_2050(int(input())), "ans en 2050")
    # # somme
    # somme = entree() + entree()
    # print("la somme vaut", somme)
    # triangle
    triangle = [Point(randint(0, 10), randint(0, 10)), Point(randint(0, 10), randint(0, 10)),
                Point(randint(0, 10), randint(0, 10))]
    # for point in triangle:
    #     print(point)
    creer_triangle_fichier_svg(triangle)
main()
