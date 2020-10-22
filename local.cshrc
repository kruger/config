
#MAC STUFF
#set DESKTOP='gabrielle'
#setenv PATH "$HOME/upstream/bin:${PATH}"
#
# Chang this
set prompt   = "gabrielle \!: "
setenv PATH $HOME/anaconda/bin:${PATH}

###
##  This is a local file -- meant to be customized per machine
##  by copying to $HOME/.tcshrc and editing.
##  Unlike the global files (e.g., global.cshrc and aliases.cshrc)
##  I work on weird systems so this has stuff that is normally global
#
set cdpath=''

###
##  For large systems where the home directory is nfs-mounted, 
##   need a local directory for high performance
##  These must be set to have stuff below work
#
#setenv SCRATCH  /scr_gabrielle/kruger
#setenv SCRATCH $TMPDIR
#alias tmpdir cd $TMPDIR
#

###
##  System-independent configurations
#
#source $HOME/config/mac.cshrc
source $HOME/config/aliases.cshrc
source $HOME/config/global.cshrc
source $HOME/config/cdargs-tcsh.csh 
source $HOME/config/git-completion.tcsh
#source $HOME/config/codes.cshrc
#source $HOME/config/techx.cshrc

# This sets the xterm title to be the basename of the current directory.
# Some systems have a hard time with this so it is
# local.  See also mac.cshrc
alias cd  'source $HOME/config/cd.tcsh'


###
## spack
#
setenv SPACK_ROOT  $HOME/spackroot/spack
setenv PATH $SPACK_ROOT/bin:${PATH}
alias spackinit 'source $SPACK_ROOT/share/spack/setup-env.csh'
# It seems that setup-env should initialized modules but it doesn't
alias spackmodinit 'source `spack location -i environment-modules`/Modules/init/tcsh'
