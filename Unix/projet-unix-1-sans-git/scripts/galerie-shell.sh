#! /bin/sh

# fonction qui montre l'utilisation de cette commande
usage () {
    cat << EOF
UTILISATION: $(basename "$0") [OPTIONS] --source REP [OPTIONS] --dest REP [OPTIONS]
INFOS:   --source REP    Choisir le repertoire contenant les images JPEG a miniaturiser
         --dest REP      Choisir le repertoire cible (ou on va generer les vignettes et le fichier HTML)
OPTIONS: --help          Ce message d'aide
         --verb          Mode "verbeux" pour mise au point
         --force         Forcer la creation de vignette, meme si la vignette existe deja
         --index FICHIER Generer la galerie dans le fichier .html specifie au lieu de generer un fichier index.html
EOF
}

# fonction qui verifie l'existence de l'argument liees aux options de la commande
verif_existence_argument () {
    if [ "$1" = "" ]; then
        printf "\n\nIl manque un argument\n\n"
        usage; exit 1
    fi
}

# fonction qui vérifie l'existence du repertoire donne en argument
verif_repertoire_argument () {
    if [ ! -d "$1" ]; then
        printf "\n\nLe repertoire \"%s\" n'existe pas\n\n" "$1"
        usage; exit 1
    fi
}

# fonction qui va normaliser les noms des repertoires source et destination en les convertissant en chemin absolu
normaliser_nom_repertoires () {
    rep_source=$(cd "$rep_source" && pwd)
    rep_dest=$(cd "$rep_dest" && pwd)
}

# fonction qui vérifie que le fichier donne en argument est bien un .html
verif_fichier_argument () {
    case "$1" in
        ?*.html)
            ;;
        *)
            printf "\n\nLe fichier \"%s\" specifie dans l'option --index doit etre un fichier .html\n\n" "$1"
            usage; exit 1
            ;;
    esac
}

# les variables concernant l'etat de la commande
rep_source=""
rep_dest=""
verb=false
force=false
index="index.html"

# chargement de la bibliotheque de fonction (possible depuis n'importe quel repertoire car conversion en chemin absolu)
DIR="$(cd "$(dirname "$0")" && pwd)"
. "$DIR"/utilities.sh

# traitement des arguments
while test $# -ne 0; do
    case "$1" in
        "--help"|"-h")
            usage
            exit 0
            ;;
        "--source")
            shift
            verif_existence_argument "$1"
            verif_repertoire_argument "$1"
            rep_source="$1"
            normaliser_nom_repertoires
            shift
            ;;
        "--dest")
            shift
            verif_existence_argument "$1"
            rep_dest="$1"
            if ! [ -d "$rep_dest" ]; then # si le repertoire destination n'existe pas encore
                mkdir "$rep_dest"
            fi
            normaliser_nom_repertoires
            shift
            ;;
        "--verb")
            verb=true
            shift
            ;;
        "--force")
            force=true
            shift
            ;;
        "--index")
            shift
            verif_existence_argument "$1"
            verif_fichier_argument "$1"
            index="$1"
            shift
            ;;
        *)
            # echo -e "\n\nArgument non reconnu : $1\n\n"
            printf "\n\nArgument non reconnu : %s\n\n" "$1"
            usage
            exit 1
            ;;
    esac

done

# appel de la fonction galerie_main() avec les parametres adequats
galerie_main "$rep_source" "$rep_dest" "$verb" "$force" "$index"
