#! /bin/sh

# Test de la sélection des images .jpg uniquement

HERE=$(cd "$(dirname "$0")" && pwd)
PATH="$HERE/..:$PATH"

rm -fr source dest
mkdir -p source dest

touch source/mauvais.txt
make-img.sh source/image1.jpg
make-img.sh source/mauvais3.png
make-img.sh source/image2.jpg
touch source/mauvais2.jp
make-img.sh source/image\*.jpg

galerie-shell.sh --source source --dest dest --verb

if [ -f dest/index.html ]
then
    echo "Now run 'firefox dest/index.html' to check the result"
else
    echo "ERROR: dest/index.html was not generated"
fi
