#!/bin/bash
#------------------------------------------------------------------
#
make_mpeg2encode_parfile.sh $@
for file in $@
do
	extension=${file##*.}
	rootname=${file%.*}
      echo 'Processing ' $file
	# mpeg2encode requires ppm files
	convert -quality 100 $file $rootname.ppm

done
mpeg2encode *.ppm
