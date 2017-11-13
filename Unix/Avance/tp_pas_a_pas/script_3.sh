#!/bin/bash

if [ -d ALL ]
then
    rm -R ALL
fi
mkdir ALL
for d in dir*
do
    cd "$d"
    for fic in *
    do
        mv "$fic" "../ALL/$d-$fic"
    done
    cd ..
    rmdir "$d"
done
