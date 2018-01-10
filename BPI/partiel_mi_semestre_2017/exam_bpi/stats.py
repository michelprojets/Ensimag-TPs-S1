# coding : utf-8

"""
quelques fonctions pour l'analyse de notre fichier de notes
"""
# remplacer les valeurs de ces variables par les valeurs vous correspondant
# en majuscules pour NOM et PRENOM, un entier entre 1 et 8 pour GROUPE
NOM = "YOEUNG"
PRENOM = "Michel"
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
        # TODO: a completer :
        # parcourir les lignes et faire un yield de chaque objet Etudiant
        # FB : pourquoi s'embêter avec tout ça? Un simple :
        # for ligne in fichier_notes:
        # suffit à parcourir un fichier ligne par ligne.
        str_fichier = fichier_notes.read()
        for ligne in str_fichier.split("\n"):
            tab_etu = ligne.split(",")
            if tab_etu == ['']:
                return
            yield Etudiant(tab_etu[0], tab_etu[1],
                           (int(tab_etu[2]), int(tab_etu[3]), int(tab_etu[4])))

def calcul_moyennes(etudiants):
    """
    prend un *iterable* sur les etudiants,
    renvoie un triplet contenant les moyennes de la promo a chaque examen.
    """
    moyenne0 = moyenne1 = moyenne2 = 0.0
    nb_etu = 0
    for etu in etudiants:
        moyenne0 += etu.notes[0]
        moyenne1 += etu.notes[1]
        moyenne2 += etu.notes[2]
        nb_etu += 1

    # FB : bravo! :-)
    moyenne0 = moyenne1/nb_etu
    moyenne1 = moyenne2/nb_etu
    moyenne2 = moyenne2/nb_etu
    return (moyenne0, moyenne1, moyenne2)


def etudiants_brillants(etudiants):
    """
    prend un *iterable* sur les etudiants,
    itere sur les etudiants ayant au moins un 20.
    a implementer si possible a l'aide de la fonction "filter".
    """
    for etu in etudiants:
        if etu.notes[0] == 20 or etu.notes[0] == 20 or etu.notes[1] == 20:
            yield etu

def min_et_max(etudiants):
    """
    prend un *iterable* sur les etudiants,
    renvoie un triplet de couples de vecteurs :
    pour chaque epreuve, tous les etudiants ayant
    la note minimale et tous les etudiants ayant la note maximale.
    """
    # FB : deux critiques principales :
    #
    # 1- il n'est pas nécessaire de faire deux parcours des étudiants (le
    # premier pour trouver les min/max, le deuxième pour insérer les étudiants
    # qui correspondent dans les vecteurs). On peut tout faire en une passe : tu
    # considères les min et max que tu as trouvés en cours de parcours, tu
    # insères les étudiants en fonction, et si en cours de parcours tu trouves
    # un nouveau min (ou un nouveau max), tu vides le vecteur correspondant et
    # tu continues.
    #
    # 2- c'est très très factorisable : un boucle pour les épreuves au moins
    # (facile), voir une boucle pour min et max (plus dur, voir correction)
    notes = [[], [], []]
    for etu in etudiants:
        notes[0].append(etu.notes[0])
        notes[1].append(etu.notes[1])
        notes[2].append(etu.notes[2])
    min0 = min(notes[0])
    min1 = min(notes[1])
    min2 = min(notes[2])
    max0 = max(notes[0])
    max1 = max(notes[1])
    max2 = max(notes[2])
    tab_min0 = []
    tab_min1 = []
    tab_min2 = []
    tab_max0 = []
    tab_max1 = []
    tab_max2 = []
    for etu in etudiants:
        if etu.notes[0] == min0:
            tab_min0.append(etu)
        if etu.notes[1] == min1:
            tab_min1.append(etu)
        if etu.notes[2] == min2:
            tab_min2.append(etu)
        if etu.notes[0] == max0:
            tab_max0.append(etu)
        if etu.notes[1] == max1:
            tab_max1.append(etu)
        if etu.notes[2] == max2:
            tab_max2.append(etu)
    return ((tab_min0, tab_max0), (tab_min1, tab_max1), (tab_min2, tab_max2))

def classement(etudiants):
    """
    prend un *iterable* sur les etudiants,
    renvoie un vecteur de couples (nom, moyenne) de tous les etudiants,
    tries selon leur moyenne.
    la moyenne est obtenue avec les coefficients suivants :
    1 pour l'epreuve 0, 1 pour l'epreuve 1 et 2 pour l'epreuve 2
    """
    classement_etu = []
    coef0 = 1
    coef1 = 1
    coef2 = 2
    coef_total = coef0 + coef1 + coef2

    for etu in etudiants:
        moyenne_etu = (etu.notes[0]*coef0 + etu.notes[1]*coef1 +
                       etu.notes[2]*coef2) / coef_total
        classement_etu.append((etu.nom, moyenne_etu))

    """ tri par selection """
    for i in range(1, len(classement_etu)):
        for j in range(i):
            if classement_etu[i][1] < classement_etu[j][1]:
                classement_etu[i], classement_etu[j] = classement_etu[j], classement_etu[i]

    return classement_etu


def histogramme(etudiants, numero_epreuve):
    """
    prend un *iterable* sur les etudiants et le numero d'une epreuve.
    genere un histogramme en baton des notes, en svg a l'aide de rectangles,
    et renvoie le nom du fichier genere
    """
    assert 0 <= numero_epreuve <= 2

    # initialisation de la liste qui représente l'histogramme
    nb_etus_ayant_note = list()
    for _ in range(21):
        nb_etus_ayant_note.append(0)
    for etu in etudiants:
        note_etu = etu.notes[numero_epreuve]
        nb_etus_ayant_note[note_etu] += 1

    pas = 20
    largeur = len(nb_etus_ayant_note)*pas
    hauteur = 320
    coord_x = 0
    with open("histo.svg", "w") as fichier_histo_svg:
        fichier_histo_svg.write("<svg width=\'" + str(largeur) + "\' height=\'" +
                                str(hauteur) + "\'>\n")
        fichier_histo_svg.write("<rect width=\'" + str(largeur) + "\' height=\'" +
                                str(hauteur) + "\' fill=\'white\'/>\n")
        for nb_etu in nb_etus_ayant_note:
            fichier_histo_svg.write("<rect x=\'" + str(coord_x) + "\' y=\'" +
                                    str(hauteur-(nb_etu*pas)) + "\' width=\'" +
                                    str(pas) + "\' height=\'" + str(nb_etu*pas) +
                                    "\' fill=\'red\'/>\n")
            coord_x += pas
        fichier_histo_svg.write("</svg>")

    return nb_etus_ayant_note
