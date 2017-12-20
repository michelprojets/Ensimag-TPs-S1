#! /bin/sh
rm -f ./WinterTreeman.stl
cp ~/Downloads/WinterTreeman.stl ./
echo
echo "Working..."
./sapinisator.py WinterTreeman.stl
echo
echo "You can now launch : meshlab WinterTreeman.stl &"
echo
