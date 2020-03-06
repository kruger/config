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


setenv PATH ".:${PATH}:${HOME}/codes/bin"

###
## Moving around
#
set cdpath=(~ $NIMROOT $NIMALL $NIMSRC $cdpath)
set cdpath=($HOME/ptsolveall $cdpath)

