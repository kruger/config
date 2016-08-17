#----------------------------------------------------------------------
# File for stuff that can be used on other machines without changes
# See local.cshrc
#----------------------------------------------------------------------
###
##  Basics
#
# I like prompt simple and consistent on all machines
set prompt   = "`hostname -s` \!: "
# Control permissions:
umask 002
# Useful csh feature
limit coredumpsize 1M

###
## This causes problems when using other peoples terminals
#
set color

# Good for dark backgrounds:
setenv LS_COLORS \
"di=33;1:fi=37;1:ln=36;1:ex=01;31:pi=40;33:so=01;34:bd=40;33;01:cd=4;33;01:*.o=37:*.mod=37:*.log=37:*.aux=37:*.toc=37:*.lof=37:*.lot=37:*.tpt=37"

# Good for light backgrounds:
#setenv LS_COLORS "ex=01;31:ln=31:fi=31:di=01;34:pi=40;33:so=01;34:bd=40;33;01:cd=4;33;01:*.tar=04;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.dvi=04;35:*.ps=04;34:*.eps=04;34:*.tex=01;32"

#
###
## Environment variables
#
setenv NAME "Scott Kruger"
setenv EDITOR vim
setenv MAIL_ADDRESS fullyionized@gmail.com

###
## Basic coding stuff
#
alias tmpdir   "cd $SCRATCH"

###
## Edit these configuration files and then source them
#
alias editcs 'vi $HOME/.tcshrc; source $HOME/.tcshrc'
alias editcg 'vi $HOME/bin/configuration/global.cshrc $HOME/bin/configuration/aliases.cshrc; source $HOME/bin/configuration/global.cshrc; source $HOME/bin/configuration/aliases.cshrc'
#

###
## Quick help
#
alias tiplin $EDITOR $HOME/.vim/doc/tips_linux.txt
alias tipmac '$EDITOR $HOME/.vim/doc/tips_mac.txt'
alias tipshl $EDITOR $HOME/.vim/doc/tips_shell.txt
alias tiptcs $EDITOR $HOME/.vim/doc/tips_tcsh.txt
alias tiptex $EDITOR $HOME/.vim/doc/tips_tex.txt
alias tipvim $EDITOR $HOME/.vim/doc/tips_vim.txt


#----------------------------------------------------------------------
###
##  Typical tcsh variables
#

set savehist=25 		# save commands (in ~/.history) b/t sessions
set history=200 		# Save history of commands
set rmstar 			# safety precaution for rm *
unset autologout 		# Don't like autologout

#----------------------------------------------------------------------
# Keyboard bindings
# 	To get these to actually work, use the CONTROL-V on the command
# 	line to get the control or alt characters to work.  Then cut and
# 	paste.
#----------------------------------------------------------------------
#
#     CONTROL-a is the normal beginning of the line, but that conflicts
#     with the command character for the "screen" program.  I like this
#     better anyway since it is the opposite of CTRL-e
#      bindkey "^[e" beginning-of-line # Alt-e

#     This is normally Alt-b, but I find that awkward
# bindkey ^[s backward-word	# Alt-s
bindkey "^p" history-search-backward
bindkey "^n" history-search-backward

###----------------------------------------------------------------------
###
##  Rest of file is due for completion
#
set autolist 		# List the possible choices when TAB complete
set autolist=ambiguous	# Show listing of what can be matched if multiple
set filec 			# Set file completion
set correct=cmd 		# for mispelled command
set fignore=(.log .aux .o .mod .bbl .tpt .lo) # for file completion

# 					Questionably useful
#    set complete=enhance

#					Only complete if special type of
#					file/command
complete cd 'p/1/d/'
complete alias   'p/1/a/'          # only aliases are valid
complete unalias 'n/1/a/'
complete man     'p/*/c/'
complete which   'n/*/c/'
complete where   'n/*/c/'
complete set     'c/*=/f/' 'p/1/s/=' 'n/=/f/'
complete unset   'n/*/s/'
complete cprundir 'p/1/d/'

#					Complete if ends w/ extension
complete pre 'n/*/f:*.dat/'
complete latex 'n/*/f:*.{tex,dtx}/'
complete pdflatex 'n/*/f:*.{tex,dtx}/'
complete acroread 'n/*/f:*.pdf/'
complete dvips 'n/*/f:*.dvi/'
complete xdvi 'n/*/f:*.dvi/'
complete kdvi 'n/*/f:*.dvi/'
complete ghostview 'n/*/f:*.{ps,pdf,eps}/'
complete kghostview 'n/*/f:*.{ps,pdf,eps}/'
complete gv 'n/*/f:*{ps,pdf}/'
complete gunzip 'n/*/f:*.*gz/'
complete untar 'n/*/f:*.tar/'
complete h5dump 'n/*/f:*.h5/'
complete h5ls 'n/*/f:*.h5/'
complete h5lr 'n/*/f:*.h5/'
complete h5la 'n/*/f:*.h5/'
complete h5diff 'n/*/f:*.h5/'

#					Don't complete if ends w/ extension
complete rm 'p/*/f:^*.{c,h,cc,C,tex,f,f90,F90,F}/'
complete vi 'n/*/f:^*.{aux,log,dvi,ps,bak,o,sty,toc,lof,lot,plt,mod,lyx,bbl,blg,tpt,pyc}/'
complete gvi 'n/*/f:^*.{aux,log,dvi,ps,bak,o,sty,toc,lof,lot,plt,mod,lyx,bbl,blg,tpt,pyc}/'


complete cvs p/1/"(add admin annotate checkout commit diff \
                   edit editors export history import init \
                   log login rdiff release remove rtag \
                   status tag unedit update watch)"/ 
complete svn p/1/"(add rm remove mv move cat co checkout commit diff \
                   edit editors export history import init \
                   log login rdiff release \
                   status tag unedit update watch)"/ 
complete hg p/1/"(add rm remove mv move cat co checkout commit diff \
                   edit editors export history import init \
                   log login release annotate serve clone pull \
                   status tag unedit update)"/ 

unset noglob
