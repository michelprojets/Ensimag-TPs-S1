#!/bin/bash

for fic in *
do
    new_name=$(echo "$fic" | sed 's/ //g')
    if ! [ "$fic" == $new_name ]
    then
        mv "$fic" $new_name
    fi
done
