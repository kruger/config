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
#
#setenv SCRATCH  /scr_gabrielle/kruger
#setenv SCRATCH $TMPDIR
#alias tmpdir cd $TMPDIR
#

###
##  System-independent configurations
#
source $HOME/config/aliases.cshrc
source $HOME/config/global.cshrc
source $HOME/config/cdargs-tcsh.csh 
source $HOME/config/git-completion.tcsh
#source $HOME/config/codes.cshrc
#source $HOME/config/techx.cshrc

# This sets the xterm title to be the basename of the current directory.
# Some systems have a hard time with this so it is
# local
alias cd  'source $HOME/config/cd.tcsh'

# I have my other global files potentially
if (-f $HOME/pim/etc/cshrc.csh) then
   source $HOME/pim/etc/cshrc.csh
endif

set DESKTOP='gabrielle'
if (-f /sw/bin/keychain ) then
   /sw/bin/keychain $HOME/.ssh/id_dsa
   set host=`hostname`
      if (-f $HOME/.keychain/$host-csh) then
              source $HOME/.keychain/$host-csh
      endif
endif

# Good for dark backgrounds:
setenv LS_COLORS \
"di=33;1:fi=37;1:ln=36;1:ex=01;31:pi=40;33:so=01;34:bd=40;33;01:cd=4;33;01:*.o=37:*.mod=37:*.log=37:*.aux=37:*.toc=37:*.lof=37:*.lot=37:*.tpt=37"

# Good for light backgrounds:
#setenv LS_COLORS "ex=01;31:ln=31:fi=31:di=01;34:pi=40;33:so=01;34:bd=40;33;01:cd=4;33;01:*.tar=04;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.dvi=04;35:*.ps=04;34:*.eps=04;34:*.tex=01;32"

set DESKTOP='gabrielle'

# Take me places quickly
#alias nrl open $HOME/Papers/NRL_FORMULARY_07.pdf
#alias mypapers cd ~/Papers/MyPapers/
#alias papers cd ~/Papers

# Set the DISPLAY variable -- works for Apple X11 with Fast User Switching

if (! $?DISPLAY && ! $?SSH_CONNECTION ) then
  setenv DISPLAY `ps -wwx | grep -F X11.app | awk '{print $NF}' | grep -e ":[0-9]"`.0
    if ( $DISPLAY == '.0' )then
       setenv DISPLAY :0.0
    endif
  echo "DISPLAY has been set to $DISPLAY"
endif   



# iTerm Tab and Title Customization and prompt customization

# Set the title bar and tabs of iTerm separately in tcsh
#
# The full path of current working directory will appear in the title bar
#
alias settitle 'echo -n "]2; "\!*""'
alias SetTitle 'settitle \[tcsh\]\ \ \ $HOST:r:r\:\:$cwd '
#
# The last two directories in the path will appear in the tab
# However, this is what will appear in the title bar of terminal.app
#
alias settab 'echo -n "]1; "\!*""'
alias SetTab 'settab $cwd:h:t/$cwd:t     '
#
# This dynamically updates both titles whenever you change directories
# If you use pushd and popd, alias them likewise to redefine them.
#
alias cd 'cd \!*;SetTab;SetTitle'
#
# Start the label update process on login to window
SetTitle;SetTab


setenv PATH "$HOME/config/bin:$HOME/config/binpy:$HOME/config/binmac:${PATH}"
setenv PATH "/usr/local/bin:${PATH}"
setenv PATH "$HOME/upstream/bin:${PATH}"
setenv PATH "/opt/homebrew/bin:$PATH"
setenv PYTHONPATH "/opt/homebrew/lib/python2.7/site-packages:$PATH"
alias mvim /Applications/MacVim.app/mvim
setenv PATH /usr/local/texlive/2014/bin/x86_64-darwin:${PATH}

# Useful for Mac
alias myps 'ps -u kruger | grep -v login | grep -v tcsh | grep -v Applications | grep -v mdworker | grep -v System | grep -v /usr/lib | grep -v Library | grep -v agilebits | grep -v /usr/sbin'

setenv PATH $HOME/anaconda/bin:${PATH}
