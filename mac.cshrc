if (-f /sw/bin/keychain ) then
   /sw/bin/keychain $HOME/.ssh/id_dsa
   set host=`hostname`
      if (-f $HOME/.keychain/$host-csh) then
              source $HOME/.keychain/$host-csh
      endif
endif

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

setenv PATH "$HOME/config/binmac:${PATH}"
setenv PATH "/opt/homebrew/bin:$PATH"
setenv PYTHONPATH "/opt/homebrew/lib/python2.7/site-packages:$PATH"
setenv PATH /usr/local/texlive/2014/bin/x86_64-darwin:${PATH}

alias mvim /Applications/MacVim.app/mvim

# Useful for Mac
alias myps 'ps -u kruger | grep -v login | grep -v tcsh | grep -v Applications | grep -v mdworker | grep -v System | grep -v /usr/lib | grep -v Library | grep -v agilebits | grep -v /usr/sbin'
