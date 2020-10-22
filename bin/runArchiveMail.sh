#!/bin/sh
export TMPDIR=$PWD
for mbox in $@; do
   echo $mbox
   python ~kruger/archivemail/archivemail \
     -d 365 --suffix '_%Y%m%d' -v \
     -o $PWD $mbox  > $mbox.out
   echo "----------------------------------"
done
