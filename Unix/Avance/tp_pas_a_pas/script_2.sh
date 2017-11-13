#!/bin/bash

for rep in $@
do
    if [ ! -d $rep ]
    then
        echo "répertoire invalide"
    else
        for fic in $rep/*
        do
            if [ -d $fic ]
            then
                echo "$fic"
            fi
        done
    fi
done
