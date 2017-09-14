#! /usr/bin/env python3
"""
module svg
"""
def creer_triangle_fichier_svg(triangle):
    """
    creation fichier qui contient du texte au format svg
    """
    fichier = open("/user/6/.base/yoeungm/home/BPI/TP1/" + triangle.svg, "w")
    texte = "<svg>"
    texte += "<g>"
    texte += "<circle cx=\"" + str(triangle[0].coord_x) + "\"cy=" + str(triangle[0].coord_y) + " r=\"10\"/>"
    texte += "<circle cx=\"" + str(triangle[1].coord_x) + "\"cy=" + str(triangle[1].coord_y) + " r=\"10\"/>"
    texte += "<circle cx=\"" + str(triangle[2].coord_x) + "\"cy=" + str(triangle[2].coord_y) + " r=\"10\"/>"
    texte += "</g>"
    texte += "</svg>"
    fichier.write(texte)
