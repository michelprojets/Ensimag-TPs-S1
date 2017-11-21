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
            echo "</div>"
            ;;
        *)
            echo "Vous devez mettre un fichier .jpg"
            ;;
    esac
}

# genere un fichier index.html dans le repertoire cible
galerie_main () {
    echo "appel de la fonction galerie_main avec les parametres $1 et $2"
}
