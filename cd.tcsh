unalias cd
#if ( $# < 1 ) then
#	cd -
#else
	cd $1
#endif
set newdir=(`basename $PWD`)


if ($?KONSOLE_DCOP) then
	# Rename konsole session if we're using konsole
	dcop $KONSOLE_DCOP_SESSION renameSession $newdir
else 
	#else if (`uname` == "Linux" ) then
	#Rename xterm title bar
	echo -n "\033]2;$newdir\007\c"
endif

alias cd  'source $HOME/config/cd.tcsh'
