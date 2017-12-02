#! /bin/sh

# Test dans le cas où on veut entrer le nom du fichier html à génerer

HERE=$(cd "$(dirname "$0")" && pwd)
PATH="$HERE/..:$PATH"

make-img.sh source/image1.jpg
make-img.sh source/image2.jpg

galerie-shell.sh --source source --dest dest --verb --index test.html

if [ -f dest/test.html ]
then
    echo "Now run 'firefox dest/test.html to check the result"
else
    echo "ERROR: dest/test.html was not generated"
fi

galerie-shell.sh --source source --dest dest --verb --index mauvais_type_fichier.htm > /dev/null

if [ -f dest/mauvais_type_fichier.htm ]
then
    echo "Now run 'firefox dest/mauvais_type_fichier.htm to check the result"
else
    echo "ERROR: dest/mauvais_type_fichier.htm was not generated"
fi
