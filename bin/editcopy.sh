#!/bin/bash
# Based on Dreyer's excellent book -- not meant to be comprehensive, but to
# catch my own common mistakes
#dontuse=("very" "really" "quite" "in fact" "just" "so " "pretty" "surely" "that said" "of course" "actually")
dontuse=("very" "really" "quite" "in fact" "just" "pretty" "surely" "that said" "of course" "actually")
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

avoid=("should of" "could of" "would of")
for verboten in "${avoid[@]}"; do
  echo "$verboten"
  for file in '*.tex'; do
     if grep -i "$verboten" $file; then 
       echo $file
       echo "         " `grep -ci "$verboten" $file`
       echo "  "
     fi
  done
done



