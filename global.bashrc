
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Don't stupidly escape variables
shopt -u progcomp

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color|*-256color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi
#
# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


#----------------------------------------------------------------------
# File for stuff that can be used on other machines without changes
# See bashrc
#----------------------------------------------------------------------

export PATH="$HOME/config/bin:$HOME/config/binpy:${PATH}"
export PATH="/usr/local/bin:${PATH}"

###
##  Basics
#
# I like prompt simple and consistent on all machines
set prompt   = "`hostname -s` \!: "
# Control permissions:
umask 002
# Useful csh feature that I'd like to get working in bash
#limit coredumpsize 1M

# Good for dark backgrounds:
export LS_COLORS=\
"di=33;1:fi=37;1:ln=36;1:ex=01;31:pi=40;33:so=01;34:bd=40;33;01:cd=4;33;01:*.o=37:*.mod=37:*.log=37:*.aux=37:*.toc=37:*.lof=37:*.lot=37:*.tpt=37"

# Good for light backgrounds:
#export LS_COLORS="ex=01;31:ln=31:fi=31:di=01;34:pi=40;33:so=01;34:bd=40;33;01:cd=4;33;01:*.tar=04;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.dvi=04;35:*.ps=04;34:*.eps=04;34:*.tex=01;32"

#
###
## Environment variables
#
export NAME="Scott Kruger"
export EDITOR=vim
export MAIL_ADDRESS="scott.e.kruger@gmail.com"
export NOTMUCH_CONFIG=$HOME/.mutt/notmuchrc

###
## Basic coding stuff
#
alias tmpdir="cd $SCRATCH"

###
## Edit these configuration files and then source them
#
alias editbs='vi $HOME/.bashrc; source $HOME/.bashrc'
alias editbg='vi $HOME/config/global.bashrc $HOME/config/aliases.bashrc; source $HOME/config/global.bashrc; source $HOME/config/aliases.bashrc;'
#

###
## Quick help
#
alias tips="$EDITOR $HOME/config/tips"

###
## Moving around
#
#TODO
#set cdpath=(~ $cdpath)

#					Networking completion
#					Automatically setup hosts.
#set hosts=(volt.txcorp.com dipole.txcorp.com enrico.txcorp.com multipole.txcorp.com fusion.txcorp.com nimrod.txcorp.com iter.txcorp.com oxygen.txcorp.com qalion.txcorp.com qasnowleopard.txcorp.com qaubuntu.txcorp.com sandybridge.txcorp.com ivy.txcorp.com haswell.txcorp.com plasma.txcorp.com phi.txcorp.com ptsolvemac.txcorp.com sekruge@srngate.sandia.gov krugers@login.mcs.anl.gov krugers@noether.colorado.edu coe0102@tulip.cray.com kruger@login1.ascent.olcf.ornl.gov krugers@orthus.nic.uoregon.edu)
#set hosts=($hosts skruger@cori.nersc.gov skruger@edison.nersc.gov hydra.gat.com skruger@euclid.nersc.gov jaguar.ccs.ornl.gov krugersc@129.244.40.23)


#					Complete on hosts
#complete ssh	p/1/\$hosts/ c/-/"(l n)"/   n/-l/u/ N/-l/c/ n/-/c/ p/2/c/ p/*/f/
#complete scp "c,*:/,F:/," "c,*:,F:$HOME," 'n/*/$hosts/:/'
#
#complete svn p/1/"(add rm remove mv move cat co checkout commit diff \
#                   edit editors export history import init \
#                   log login rdiff release \
#                   status tag unedit update watch)"/ 
#
####
### Common machines
#
alias noether="ssh krugers@noether.colorado.edu"
alias sandia="ssh sekruge@srngate.sandia.gov"
alias dipole="ssh kruger@dipole.txcorp.com"
alias fusion="ssh kruger@fusion.txcorp.com"
alias hydra="ssh hydra.gat.com"
alias franklin="ssh skruger@franklin.nersc.gov"
alias carver="ssh skruger@carver.nersc.gov"
alias hopper="ssh skruger@hopper.nersc.gov"
alias bassi="ssh skruger@bassi.nersc.gov"
alias davinci="ssh skruger@davinci.nersc.gov"
alias volt="ssh volt.txcorp.com"
alias dipole="ssh dipole.txcorp.com"
alias multipole="ssh multipole.txcorp.com"
alias enrico="ssh enrico.txcorp.com"
alias iter="ssh iter.txcorp.com"
alias sandybridge="ssh sandybridge.txcorp.com"
alias sb="ssh sandybridge.txcorp.com"
alias hip="ssh hip.txcorp.com"
alias ascent="kruger@login1.ascent.olcf.ornl.gov"
alias vsb=" ssh -t dipole.txcorp.com ssh -A -t sandybridge.txcorp.com"
alias vivy="ssh -t dipole.txcorp.com ssh -A -t ivy.txcorp.com"
alias vphi="ssh -t dipole.txcorp.com ssh -A -t phi.txcorp.com"
alias vhip="ssh -t dipole.txcorp.com ssh -A -t hip.txcorp.com"
alias cybele="ssh -p 2039 kruger@cybele.gat.com"
alias voxy="ssh -t dipole.txcorp.com ssh -A -t oxygen.txcorp.com"
alias vhaswell="ssh -t dipole.txcorp.com ssh -A -t haswell.txcorp.com"
alias ivy="ssh ivy.txcorp.com"
alias phi="ssh phi.txcorp.com"
alias ptmac="ssh ptsolvemac.txcorp.com"
alias haswell="ssh haswell.txcorp.com"
alias plasma="ssh plasma.txcorp.com"
alias qalion="ssh qalion.txcorp.com"
alias qasnowleopard="ssh qasnowleopard.txcorp.com"
alias qaubuntu="ssh qaubuntu.txcorp.com"
alias oxygen="ssh oxygen.txcorp.com"
alias tatanka="ssh krugersc@129.244.40.23"
alias loki="ssh -X -t cmodws29.psfc.mit.edu  ssh loki.psfc.mit.edu"
alias mcs="ssh krugers@login.mcs.anl.gov"
alias tulip="ssh coe0102@tulip.cray.com"
