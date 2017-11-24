#! /bin/sh

# genere l'entete de page HTML en sortie standard
html_head () {
    echo "<!DOCTYPE html>"
    echo "<html>"
    echo "<head>"
    echo "<meta charset=\"UTF-8\">"
    echo "<title>"$1"</title>"
    echo "</head>"
    echo "<body>"
}

# genere le titre de page HTML en sortie standard
html_title () {
    echo "<h1>"$1"</h1>"
}

# genere le pied de page HTML en sortie standard
html_tail () {
    echo "</body>"
    echo "</html>"
}

# genere un bloc image de la page HTML en sortie standard
generate_img_fragment () {
    nom_fich=$(basename $1)
    case "$nom_fich" in
        ?*.jpg)
            echo "<div style=\"float:left\">"
            echo "<img src=\"$nom_fich\" alt=\"$nom_fich\"><br>"
            echo "<span>$nom_fich</span>"
            echo "</div>"
            ;;
        *)
            ;;
    esac
}

# genere un fichier index.html dans le repertoire cible
galerie_main () {
    if ! [ -d $2 ]; then  # si le repertoire destination n'existe pas encore
        mkdir $2
    fi
    cd $2
    fichier=""
    if [ $3 != "" ]; then # si un fichier a ete specifie pour remplacer index.html
        fichier=$3
        html_head "projet-unix-1" > $fichier
    else  # sinon on cree un fichier index.html pour ecrire dedans
        fichier="index.html"
        html_head "projet-unix-1" > $fichier
    fi
    # generation des vignettes
    for fic in $1/*
    do
        case "$fic" in
            ?*.jpg)
                echo $fic
                gmic $fic -cubism , -resize 400,400 -output $2/$(basename $fic)
                generate_img_fragment $2/$(basename $fic) >> $fichier
                ;;
            *)
                ;;
        esac
    done
    html_tail >> $fichier
}