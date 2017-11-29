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
            echo "<div style =\"float:left\">"
            echo "<img src=\"$nom_fich\" alt=\"IMAGE : $nom_fich INTROUVABLE\"><br>"
            echo "<span>Nom de l'image : $nom_fich</span><br>"
            echo "<span>Date de prise de vue : "$(identify -format "%[EXIF:DateTimeOriginal]" $2/$nom_fich)"</span><br>"
            echo "<span>Resolution : "$(identify -format "%wx%h" $2/$nom_fich)"</span>"
            echo "</div>"
            ;;
        *)
            ;;
    esac
}

# miniaturise les fichiers mis dans le répertoire destination
miniaturisation(){
  if [[ $3 = true ]]; then # mode verbeux
      echo -e "\n$1 -> $2/$(basename $1)..."
  fi
  gmic $1 -resize 200,200 -output $2/$(basename $1) 2> /dev/null
}

# genere un fichier index.html dans le repertoire cible
galerie_main () {
    cd $2
    fichier=$5
    html_head "projet-unix-1" > $fichier
    # generation des vignettes
    echo -e "\nworking..."
    for fic in $1/*
    do
        case "$fic" in
            ?*.jpg)
                if [[ $4 = true ]]; then  # on force la miniaturisation
                    miniaturisation $fic $2 $3
                else
                    if [ ! -f "$2/$(basename $fic)" ]; then
                        # on miniaturise seulement lorsque le fichier n'existe pas encore dans le fichier destination
                        miniaturisation $fic $2 $3
                    fi
                fi
                generate_img_fragment $2/$(basename $fic) $1 >> $fichier
                ;;
            *)
                ;;
        esac
    done
    html_tail >> $fichier
}
