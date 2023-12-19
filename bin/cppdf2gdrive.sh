#!/bin/sh
gdrive='/Users/kruger/Library/CloudStorage/GoogleDrive-scott.e.kruger@gmail.com/My Drive/Reading'
if test -n "$2"; then
    mvdir="$gdrive/$2" 
    if ! test -d "$mvdir"; then
      mkdir "$mvdir"
    fi
else    
    mvdir="$gdrive/$2" 
fi    
echo  "$1" "$mvdir"
cp -i "$1" "$mvdir"
