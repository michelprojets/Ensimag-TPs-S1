#! /bin/sh

# fonction qui montre l'utilisation de cette commande
usage () {
    cat << EOF
Utilisation: $(basename "$0") [options]
Options: --help          Ce message d'aide
         --source REP    Choisir le repertoire contenant les images JPEG a miniaturiser
         --dest REP      Choisir le repertoire cible (ou on va generer les vignettes et le fichier HTML)
         --verb          Mode \"verbeux\" pour mise au point
         --force         Forcer la creation de vignette, meme si la vignette existe deja
         --index FICHIER Generer la galerie dans le fichier specifie au lieu de generer un fichier index.html
EOF
}

# chargement de la bibliotheque de fonction
DIR=$(pwd)
. "$DIR/utilities.sh"

# traitement des arguments
while test $# -ne 0; do
    case "$1" in
        "--help"|"-h")
            usage
            exit 0
            ;;
        "--source")
            shift
            if [ "$1" = "" ]; then
                echo "Il manque un argument"
                usage; exit 1
            fi
            rep_source=$1
            shift
            ;;
        "--dest")
            shift
            if [ "$1" = "" ]; then
                echo "Il manque un argument"
                usage; exit 1
            fi
            rep_dest=$1
            shift
            ;;
        "--verb")
            echo "argument --verb"
            exit 0
            ;;
        "--force")
            shift
            case "$1" in
                ?*.jpg)
                    rep_source=$1
                    shift
                    ;;
                *)
                    echo "Vous devez mettre un fichier .jpg"
                    ;;
            esac
            ;;
        "--index")
            echo "argument --index"
            exit 0
            ;;
        *)
            echo "Argument non reconnu : $1"
            usage
            exit 1
            ;;
    esac

done

# juste un petit test
echo "rep_source=$rep_source"
echo "rep_dest=$rep_dest"

# appel de la fonction galerie_main() avec les parametres adequats
galerie_main $rep_source $rep_dest
