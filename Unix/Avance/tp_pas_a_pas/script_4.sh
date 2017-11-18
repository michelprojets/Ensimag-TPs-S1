#!/bin/bash

cd ALL/
for fic in *
do
    comment="# "
    comment="$comment Date derniere modification : "
    date=$(stat --format=%y $fic)
    echo $comment$date >> $fic
done
