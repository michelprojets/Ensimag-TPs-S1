#! /bin/sh
case "$1" in
    ?*.stl)
        rm -f ./$1
        cp ./tests/$1 ./
        echo
        echo "Working..."
        ./sapinisator.py $1
        echo
        echo "You can now launch : meshlab $1 &"
        echo
        ;;
    *)
        echo
        echo "Error - only work with .stl file"
        echo
        ;;
esac
