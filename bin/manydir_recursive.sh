#!/bin/sh
script=`readlink -e $0`

for file in *; do # For all files in this dir...
 if test -d $file; then # If the file is a directory...
   cd $file # descend into the directory
   pwd # print the current working directory
   $script # run this script (recursion)
   cd .. # when done, cd up one level
 fi
done
