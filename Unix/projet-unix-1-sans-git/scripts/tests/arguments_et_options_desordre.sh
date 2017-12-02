#! /bin/sh

# Test dans le cas où on appelle la commande avec tous les arguments et toutes les options dans le désordre

HERE=$(cd "$(dirname "$0")" && pwd)
PATH="$HERE/..:$PATH"

rm -fr source dest
mkdir -p source dest

make-img.sh source/image1.jpg
make-img.sh source/image2.jpg

galerie-shell.sh --index test.html --dest dest --force --source source --verb

if [ -f dest/test.html ]
then
    echo "Now run 'firefox dest/test.html' to check the result"
else
    echo "ERROR: dest/test.html was not generated"
fi
