#! /usr/bin/env python3
"""
module principal echiquier
"""
def generer_case(couleur, coord_x, coord_y):
    """
    fonction qui génère en svg un rectangle à une position
    de couleur noire si couleur = 'n'
    de couleur blanche si couleur = 'b'
    """
    # on vérifie que les positions sont des multiples de 100
    assert coord_x%100 == 0 and coord_y%100 == 0
    if couleur == 'n':  # couleur noire
        return ("<rect x=\"" + str(coord_x) + "\" y=\"" +
                str(coord_y) + "\" width=\"100\" height=\"100\"" +
                " style=\"fill:rgb(0,0,0);stroke-width:0;\" />")
    else:
        if couleur == 'b':  # couleur blanche
            return ("<rect x=\"" + str(coord_x) + "\" y=\"" +
                    str(coord_y) + "\" width=\"100\" height=\"100\"" +
                    " style=\"fill:rgb(255,255,255);stroke-width:0;\" />")
def main():
    """
    programme principal
    """
    print("<svg width=\"1000\" height=\"1000\">")
    coord_x = 0
    coord_y = 0
    for ligne in range(8):
        if ligne%2 == 0:    # si la ligne est paire, elle commence par un blanc
            for colonne in range(8):
                if colonne%2 == 0:  # si la colonne est paire, elle commence par un blanc
                    print(generer_case('b', coord_x, coord_y))
                else:   # sinon, colonne impaire, elle commence par un noir
                    print(generer_case('n', coord_x, coord_y))
                coord_y += 100  # position de la colonne courante
                coord_y %= 800
        else:   # sinon, ligne impaire, elle commence par un noir
            for colonne in range(8):
                if colonne%2 == 0:  # si la colonne est paire, elle commence par un noir
                    print(generer_case('n', coord_x, coord_y))
                else:   # sinon, colonne impaire, elle commence par un blanc
                    print(generer_case('b', coord_x, coord_y))
                coord_y += 100  # position de la colonne courante
                coord_y %= 800
        coord_x += 100   # position de la ligne courante
    print("</svg>")
main()
