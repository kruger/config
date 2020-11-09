#!/bin/bash
# See:
# https://developers.google.com/style/inclusive-documentation
#
# This is a stupid script.  It's meant to catch obvious stuff, but there is no
# NLP or AI here.

dontuse=("crazy" "sanity" "cripple" "man" "him" "her" "she" "he")
for verboten in "${dontuse[@]}"; do
  echo "$verboten"
  for file in '*.tex'; do
     #if grep -i -e ' $verboten ' -e^$verboten -e \ $verboten'$' $file; then 
     #results=`grep -i -e ' $verboten ' -e^$verboten -e \ $verboten'$' $file`
     results=`grep -i -e " $verboten " -e^"$verboten" -e \ "$verboten"'$' $file`
     if test -n "$results"; then
       #echo $file
       #echo "         " `grep -i -e " $verboten " -e"^$verboten" -e "\ $verboten'$'" $file`
       echo "--"
       grep -i -e " $verboten " -e^"$verboten" -e \ "$verboten"'$' $file
       echo "--"
       echo "  "
     fi
  done
done
