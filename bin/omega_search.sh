#!/bin/sh


###
## Method to print usage
#
print_usage() {
cat >&2 <<EOF
Usage: $0 [options] index

OPTIONS
  -h ................ help: print this message

AND— Matches documents where both words or expressions match
OR— Matches documents where either expressions match
NOT— Matches documents where the first subexpression
XOR— Matches documents where either the first or second expression match, but not both
  + and - to mark words. For example: +dog +cat -poodles.
EOF
}
###
##  process optons
#
printcmd=false
while getopts "hi:" arg
do
  case $arg in
    i ) index="$OPTARG"  ;;
    h ) print_usage; exit    ;;  
  esac
done
shift $(( $OPTIND - 1 ))

if test -z "$index"; then
    index=`ls | grep \.db | head -1`
    if test -z "$index"; then
        echo "Need to specify index"
        exit
    fi
fi

#AND— Matches documents where both words or expressions match
#OR— Matches documents where either expressions match
#NOT— Matches documents where the first subexpression
#XOR— Matches documents where either the first or second expression match, but not both
#  + and - to mark words. For example: +IBM +Java -WebSphere.
quest --db=$index "$@"  | grep url | sed 's/url=//'
