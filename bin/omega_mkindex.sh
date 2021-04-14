#!/bin/sh

###
## Method to print usage
#
print_usage() {
cat >&2 <<EOF
Usage: $0 [options]

OPTIONS
  -d <dir> .......... directory to index (default is current dir)
  -n <name> ......... name of index (default is dirname of directory)
  -s <store dir> .... directory to store index (default is directory
                       unless \$HOME/indexes exists)                          
  -p ................ print index command, but don't run
  -h ................ help: print this message
EOF
}
###
##  process optons
#
directory=$PWD
set_name=false
set_storedir=false
printcmd=false
while getopts "d:n:ps:h" arg
do
  case $arg in
    d ) directory="$OPTARG"  ;;
    n ) name="$OPTARG";
        set_name=true        ;;
    s ) store_dir="$OPTARG";
        set_storedir=true    ;;
    p ) printcmd=true        ;;  
    h ) print_usage; exit    ;;  
  esac
done
shift $(( $OPTIND - 1 ))

if ! $set_name; then
   name=`basename $directory`
fi
if ! $set_storedir; then
   if test -d "$HOME/indexes"; then
      store_dir="$HOME/indexes"
   else
      store_dir=$directory
   fi
fi

###
##  Index directory: filter latex and rtf files using pandoc
#
cmd="omindex -p --db $store_dir/$name \
       --url $name \
       --filter=text/x-tex:'pandoc --quiet' \
       --filter=text/rtf:'pandoc --quiet' \
       $directory"

if $printcmd; then
      echo $cmd
else
      eval $cmd
fi
