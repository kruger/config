#!/bin/bash

bname=`basename $1`
nohup $@  1> $bname.out  2>&1 </dev/null &
exit
