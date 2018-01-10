# coding: utf8

"""
quelques fonctions pour l'analyse de notre fichier de notes
"""
# remplacer les valeurs de ces variables par les valeurs vous correspondant
# en majuscules pour NOM et PRENOM, un entier entre 1 et 8 pour GROUPE
NOM = "BROQUEDIS"
PRENOM = "FRANCOIS"
GROUPE = 2

print("vous etes '{}, {}', etudiant dans le groupe {}".format(NOM, PRENOM, GROUPE))

class Etudiant:
    """
    les infos pour un etudiant
    """
    #pylint: disable=too-few-public-methods
    def __init__(self, prenom, nom, notes):
        """
        note : les trois notes sont des entiers entre 0 et 20
        """
        self.prenom = prenom
        self.nom = nom
        self.notes = notes

def parcours_notes(nom_fichier):
    """
    ouvre le fichier de notes (dont le nom est nom_fichier)
    et itere sur tous les etudiants (de la classe Etudiant)
    """
    with open(nom_fichier, "r") as fichier_notes:
        # pas besoin de faire plus compliqué pour itérer sur les lignes d'un
        # fichier!
        for ligne in fichier_notes:
            # on utilise split (cf sujet)
            # pas besoin de traiter le retour à la ligne (\n) en fin de ligne,
            # l'opérateur de conversion le fait pour nous.
            # exemple :
            # In [4]: chaine = "42\n"
            # In [5]: int(chaine)
            # Out[5]: 42
            nom, prenom, note1, note2, note3 = ligne.split(",")
            # rappel: le 3e paramètre du constructeur d'Etudiant doit être un
            # triplet de notes.
            yield Etudiant(nom, prenom, (note1, note2, note3))

def calcul_moyennes(etudiants):
    """
    prend un *iterable* sur les etudiants,
    renvoie un triplet contenant les moyennes de la promo a chaque examen.
    """
    moy = [0, 0, 0]
    nb_etudiants = 0
    for etu in etudiants:
        for exam, note in enumerate(etu.notes):
            # attention, les notes sont des chaines de caractères.
            # on aurait aussi pu les convertir en entier dans parcours_notes().
            moy[exam] += int(note)
        nb_etudiants += 1
    return moy[0]/nb_etudiants, moy[1]/nb_etudiants, moy[2]/nb_etudiants

def etudiants_brillants(etudiants):
    """
    prend un *iterable* sur les etudiants,
    itere sur les etudiants ayant au moins un 20.
    a implementer si possible a l'aide de la fonction "filter".
    """
    for etu in etudiants:
        if etu.notes[0] == 20 or etu.notes[1] == 20 or etu.notes[2] == 20:
            yield etu

    # avec filter, ça donne:
    # return filter(lambda e: 20 in e.notes, etudiants)

def min_et_max(etudiants):
    """
    prend un *iterable* sur les etudiants,
    renvoie un triplet de couples de vecteurs :
    pour chaque epreuve, tous les etudiants ayant
    la note minimale et tous les etudiants ayant la note maximale.
    """
    # les objets tuple n'étant pas modifiables, on travaille sur des
    # list() ici.
    etu_note = [[list(), list()], [list(), list()], [list(), list()]]

    # on itère sur les trois examens
    for epreuve in range(3):
        # on initialise la note min à 20 et la note max à 0
        note = [20, 0]
        # on traite d'abord les notes min, puis les notes max
        # (factorisation du code)
        for minmax in range(2):
            # utilisé pour factoriser le code : coeff vaut 1 quand on traite les
            # notes min, -1 quand on traite les notes max
            coeff = 1 if minmax == 0 else -1
            # on parcourt ensuite la liste des étudiants
            for etu in etudiants:
                # c'est ici qu'on factorise, au lieu d'écrire :
                # if etu.notes[epreuve] < note[0]:
                #   ...
                # pour mettre à jour le min puis :
                # if etu.notes[epreuve] > note[1]:
                #   ...
                # pour mettre à jour le max, on fait factorise ces
                # deux parties à l'aide du coeff :
                # if ((etu.notes[epreuve] - note[0]) * 1) < 0
                # est équivalent à if etu.notes[epreuve] < note[0]
                # et
                # if ((etu.notes[epreuve] - note[1]) * -1) > 0
                # est équivalent à if etu.notes[epreuve] > note[1]
                if ((etu.notes[epreuve] - note[minmax]) * coeff) < 0:
                    # nouveau min (ou nouveau max), on met à jour note[]
                    # et on vide la liste correspondante.
                    note[minmax] = etu.notes[epreuve]
                    etu_note[epreuve][minmax] = [etu]
                elif etu.notes[epreuve] == note[minmax]:
                    # on a trouvé un étudiant de note min (ou de note max), on
                    # l'ajoute à la liste correspondante.
                    etu_note[epreuve][minmax].append(etu)

    # ici, on triche... On retourne des vecteurs au lieu de retourner des tuples.
    # en pratique, vu l'utilisation qu'on en fait, ça fonctionne! Si on avait voulu
    # respecter la spec du sujet, il aurait fallu écrire :
    # return (etu_note[0][0], etu_note[0][1]), \
    #        (etu_note[1][0], etu_note[1][1]), \
    #        (etu_note[2][0], etu_note[2][1])
    return etu_note

def calculer_moyenne(etu, coeffs):
    """
    retourne la moyenne de l'etudiant, en fonction des coeffs passes en
    parametre.
    """
    return (coeffs[0] * etu.notes[0]
            + coeffs[1] * etu.notes[1]
            + coeffs[2] * etu.notes[2]) / sum(coeffs)

def indice_insertion_moyenne(couples_tries, moyenne):
    """
    retourne l'indice dans le vecteur couples_tries ou inserer la moyenne passee
    en parametre.
    """
    for indice, couple in enumerate(couples_tries):
        # couple[0] représente le nom, couple[1] la moyenne
        if couple[1] > moyenne:
            # l'élément en position indice est le premier élément (en partant de
            # la gauche) à être strictement supérieur à l'élément qu'on
            # souhaite insérer. On retourne son indice.
            return indice

    # on n'a trouvé aucun élément supérieur, on insère en fin de vecteur.
    return len(couples_tries)

def classement(etudiants):
    """
    prend un *iterable* sur les etudiants,
    renvoie un vecteur de couples (nom, moyenne) de tous les etudiants,
    tries selon leur moyenne.
    la moyenne est obtenue avec les coefficients suivants :
    1 pour l'epreuve 0, 1 pour l'epreuve 1 et 2 pour l'epreuve 2
    """
    coeffs = [1, 1, 2]
    couples_tries = list()

    # our tous les étudiants...
    for etu in etudiants:
        # ... on calcule leur moyenne ...
        moyenne = calculer_moyenne(etu, coeffs)
        # ... ou trouve leur place dans le vecteur trié de sortie ...
        rang = indice_insertion_moyenne(couples_tries, moyenne)
        # ... puis on insère au bon endroit.
        couples_tries.insert(rang, (etu.nom, moyenne))

    # on pouvait aussi demander à python de trier le vecteur de sortie pour
    # nous. Ca s'écrit en deux lignes, et ça aurait donné :

    # couples = [(etu.nom, calculer_moyenne(etu, coeffs)) for etu in etudiants]
    # return sorted(couples, key=lambda couple: couple[1])

    # le paramètre key= permet de spécifier une fonction à appliquer aux éléments
    # de couples avant de les trier. Le tri s'effectue sur ces éléments-là.
    # Ici, on s'en sert pour appliquer le tri à l'entrée numéro 1 de chaque couple,
    # c'est-à-dire la moyenne.

    return couples_tries

def histogramme(etudiants, numero_epreuve):
    """
    prend un *iterable* sur les etudiants et le numero d'une epreuve.
    genere un histogramme en baton des notes, en svg a l'aide de rectangles,
    et renvoie le nom du fichier genere
    """
    # tableau des distributions, indexé par la note
    distribution = [0 for _ in range(21)]

    # on le remplit
    for etudiant in etudiants:
        distribution[etudiant.notes[numero_epreuve]] += 1

    # on adapte la hauteur de l'image en fonction de la valeur la plus grande à
    # afficher
    hauteur = (max(distribution)+1) * 20

    # on numérote le fichier généré en fonction de l'épreuve
    nom_fichier = "distribution_{}.svg".format(numero_epreuve)

    # c'est parti! on ouvre le fichier en écriture
    with open(nom_fichier, "w") as svg:
        # on écrit l'entête SVG. on utilise ici le paramètre optionnel file= de
        # print, qui permet de redigirer les écritures dans un fichier.
        print("<svg width='420' height='{}'>".format(hauteur), file=svg)

        # on dessine le rectangle blanc correspondant au fond.
        print("<rect width='420' height='{}' fill='white'/>".format(hauteur), file=svg)

        # on va maintenant s'occuper des barres
        for note, occurrence in enumerate(distribution):
            # pour chacune des notes, on dessine un histogramme sauf si personne
            # n'a eu cette note, et on écrit la graduation correspondante sur
            # l'axe des abscisses.
            if occurrence != 0:
                print("<rect width='20' height='{}' x='{}' y='{}' fill='red'/>".format(
                        occurrence*20,
                        note*20,
                        hauteur-(occurrence+1)*20),
                        file=svg)
            print("<text x='{}' y='{}'>{}</text>".format(note*20, hauteur, note), file=svg)

        # on finit par le pied de page (balise de fermeture) SVG
        print("</svg>", file=svg)

    # on retourne le nom du fichier, comme demandé par la spec
    return nom_fichier
