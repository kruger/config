#!/bin/sh

dir=`dirname $0`
absdir=`(cd $dir; pwd -P)`
name=`basename $0`

for dir in *; do
   if test -d $dir/.svn; then
       cd $dir
       $absdir/$name $*
       cd ..
   fi
done

pwd
svn propget svn:ignore . > ignore$$
echo $* | tr ' ' '\n' >> ignore$$ | sort -u ignore$$ -o ignore$$
svn propset svn:ignore . --file ignore$$
rm -f ignore$$
