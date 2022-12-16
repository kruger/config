
###
##  Other file sourcing
#
source $HOME/config/ssh_completion.bashrc
source $HOME/config/aliases.bashrc
###
##  Basics
#
# I like prompt simple and consistent on all machines
# Doesn't work with starfish
PROMPT_CONTROL="`hostname -s`: "

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# This is mostly for MacOS
export XDG_CONFIG_HOME="$HOME/.config"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Don't stupidly escape variables
shopt -u progcomp
shopt -s direxpand


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

