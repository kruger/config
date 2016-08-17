###
## Code environment variables
#
set nimsvn="https://nimrodteam.org/svn"
if ($?NIMROOT == 0) setenv NIMROOT $HOME/nimroot
#if ($?SCRATCH == 1) setenv NIMBLD $SCRATCH/nimroot/nimdevel/build1
setenv NIMALL $NIMROOT/nimall
setenv NIMSRC $NIMROOT/nimall/nimdevel/
setenv NIMRGR $NIMROOT/regress/
#if ($?NIMSRC  == 0) setenv NIMSRC $NIMROOT/nimteam/Source
if ($?DRAWDIR == 0) setenv DRAWDIR $NIMSRC/draw
if ($?NEAR    == 0) setenv NEAR $HOME/near
if ($?TOQ     == 0) setenv TOQ $HOME/eq/toq

###
## NIMROD Code workflow
#
alias editnotes  'nimdex -justnotes'
alias viewnotes  'nimdex -stdout -justnotes'
alias viewcomments  'nimdex -stdout -noedit -noeditnotes \!$'
set tmp_rootdir=$NIMROOT/rundir
alias set_tmprootdir  "set tmp_rootdir=`dirname $PWD`"
alias editnotes  "$EDITOR `basename $tmp_rootdir`_notes"
set status_file=$SCRATCH/run_status
alias editstatus  "$EDITOR $status_file"
alias viewstatus  "cat $status_file"


###
## FACETS
#
setenv FACETS $HOME/fcroot/
alias facets cd $FACETS
setenv FACETSPKG $HOME/fcroot/facetspkgs/phystools
alias facetspkgs cd $FACETSPKG
setenv FACETSALL $HOME/fcroot/facetsall/
alias facetsall cd $FACETSALL
setenv FMCFMDIR $FACETSALL/fmcfm
alias fmcfm cd $FMCFMDIR
setenv FGDIR $FACETSALL/fluxgrid
alias fgdir cd $FGDIR
setenv UEDGE $HOME/fcroot/facetsall/uedge
alias uedge cd $UEDGE


setenv PATH ".:${PATH}:${NEAR}/bin:${HOME}/codes/bin"

###
## Moving around
#
set cdpath=(~ $NIMROOT $NIMALL $NIMSRC $NEAR $NEAR/Source $cdpath)
set cdpath=($FACETSPKG $FACETSALL $cdpath)
set cdpath=($HOME/ptsolveall $cdpath)

