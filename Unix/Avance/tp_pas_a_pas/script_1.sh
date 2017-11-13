#!/bin/bash

if [ $1 -le $2 ]
then
    if [ $1 -eq $2 ]
    then
        echo "Les nombres $1 et $2 sont égaux"
    else
        echo "Le nombre $1 est inférieur au nombre $2"
    fi
else
    echo "Le nombre $1 est supérieur au nombre $2"
fi
