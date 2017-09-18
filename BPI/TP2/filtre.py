#! /usr/bin/env python3
"""
module principal filtre
"""
from point import Point

def main():
    """
    programme principal
    """
    print("<svg width=\"640\" height=\"480\">")
    point = Point()
    for i in range(1000):
        i = i
        point.set_coords(input(), input())
        print(point.draw_svg())
    print("</svg>")
main()
