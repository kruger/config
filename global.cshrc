#----------------------------------------------------------------------
#
# File for stuff that can be used on other machines without changes
# See local.cshrc
#----------------------------------------------------------------------

setenv PATH "$HOME/config/bin:$HOME/config/binpy:${PATH}"
setenv PATH "/usr/local/bin:${PATH}"

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
alias editcg 'vi $HOME/config/global.cshrc $HOME/config/aliases.cshrc  $HOME/config/mac.cshrc $HOME/config/aliases.bash; source $HOME/config/global.cshrc; source $HOME/config/aliases.cshrc; source $HOME/config/mac.cshrc'
#

###
## Quick help
#
alias tips $EDITOR $HOME/config/tips

###
## Moving around
#
set cdpath=(~ $cdpath)

#----------------------------------------------------------------------
###
##  Typical tcsh variables
#

set savehist=25 		# save commands (in ~/.history) b/t sessions
set history=200 		# Save history of commands
set rmstar 			# safety precaution for rm *
unset autologout 		# Don't like autologout

#----------------------------------------------------------------------
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


#					Networking completion
#					Automatically setup hosts.

set hosts=(volt.txcorp.com dipole.txcorp.com enrico.txcorp.com multipole.txcorp.com fusion.txcorp.com nimrod.txcorp.com iter.txcorp.com oxygen.txcorp.com qalion.txcorp.com qasnowleopard.txcorp.com qaubuntu.txcorp.com sandybridge.txcorp.com ivy.txcorp.com haswell.txcorp.com plasma.txcorp.com phi.txcorp.com ptsolvemac.txcorp.com sekruge@srngate.sandia.gov krugers@login.mcs.anl.gov krugers@noether.colorado.edu coe0102@tulip.cray.com kruger@login1.ascent.olcf.ornl.gov)
set noglob
if ( ! $?hosts ) set hosts
set hosts=($hosts)

# Hosts where I have a different login name:
set hosts=($hosts skruger@cori.nersc.gov skruger@edison.nersc.gov hydra.gat.com skruger@euclid.nersc.gov jaguar.ccs.ornl.gov krugersc@129.244.40.23)


#					Complete on hosts
complete ftp 'p/1/$hosts/'
complete ywho  'n/*/$hosts/'
complete rsh	p/1/\$hosts/ c/-/"(l n)"/   n/-l/u/ N/-l/c/ n/-/c/ p/2/c/ p/*/f/
complete ssh	p/1/\$hosts/ c/-/"(l n)"/   n/-l/u/ N/-l/c/ n/-/c/ p/2/c/ p/*/f/
complete rlogin 	p/1/\$hosts/ c/-/"(l 8 e)"/ n/-l/u/
complete telnet 	p/1/\$hosts/ p/2/x:'<port>'/ n/*/n/
complete scp "c,*:/,F:/," "c,*:,F:$HOME," 'n/*/$hosts/:/'

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

# Other useful way of automatically getting hosts:
#    foreach f (/etc/hosts)
#        if ( -r $f ) then
#	    set hosts = ($hosts `grep ^"[1-9]" /etc/hosts | tr -s " " " " | cut -f2 -d " " `)
#	endif
#    end



# I've tried many scp versions:
#     complete scp 'n/*/f/' 'p/*/$hosts/'
    # this one is simple...
    #complete scp 'c/*:/f/' 'C@[./\$~]*@f@ n/*/\$hosts/:'
    # From Michael Schroeder <mlschroe@immd4.informatik.uni-erlangen.de> 
    # This one will rsh to the file to fetch the list of files!
#    complete rcp 'c%*@*:%`set q=$:-0;set q="$q:s/@/ /";set q="$q:s/:/ /";set q=($q " ");rsh $q[2] -l $q[1] ls -dp $q[3]\*`%' 'c%*:%`set q=$:-0;set q="$q:s/:/ /";set q=($q " ");rsh $q[1] ls -dp $q[2]\*`%' 'c%*@%$hosts%:' 'C@[./$~]*@f@'  'n/*/$hosts/:'

#complete scp "c,*:/,F:/," "c,*:,F:$HOME," 'c/*@/$hosts/:/'
#complete scp	'p/*/$hosts/' 'p/*/f/' 
#complete scp 'c/*:/f/' 'n/*/\$hosts/:'
#
#curl -O http://paginas.terra.com.br/servicos/lstec/mdig/imagens/[1955-2006][01-12].jpg

###
## Common machines
#
alias noether ssh krugers@noether.colorado.edu
alias sandia ssh sekruge@srngate.sandia.gov
alias dipole ssh kruger@dipole.txcorp.com
alias fusion ssh kruger@fusion.txcorp.com
alias hydra ssh hydra.gat.com
alias franklin ssh skruger@franklin.nersc.gov
alias carver ssh skruger@carver.nersc.gov
alias hopper ssh skruger@hopper.nersc.gov
alias bassi ssh skruger@bassi.nersc.gov
alias davinci ssh skruger@davinci.nersc.gov
alias volt ssh volt.txcorp.com
alias dipole ssh dipole.txcorp.com
alias multipole ssh multipole.txcorp.com
alias enrico ssh enrico.txcorp.com
alias iter ssh iter.txcorp.com
alias sandybridge ssh sandybridge.txcorp.com
alias sb ssh sandybridge.txcorp.com
alias hip ssh hip.txcorp.com
alias ascent kruger@login1.ascent.olcf.ornl.gov
alias vsb  ssh -t dipole.txcorp.com ssh -A -t sandybridge.txcorp.com
alias vivy ssh -t dipole.txcorp.com ssh -A -t ivy.txcorp.com
alias vphi ssh -t dipole.txcorp.com ssh -A -t phi.txcorp.com
alias vhip ssh -t dipole.txcorp.com ssh -A -t hip.txcorp.com
alias voxy ssh -t dipole.txcorp.com ssh -A -t oxygen.txcorp.com
alias vhaswell ssh -t dipole.txcorp.com ssh -A -t haswell.txcorp.com
alias ivy ssh ivy.txcorp.com
alias phi ssh phi.txcorp.com
alias ptmac ssh ptsolvemac.txcorp.com
alias haswell ssh haswell.txcorp.com
alias plasma ssh plasma.txcorp.com
alias qalion ssh qalion.txcorp.com
alias qasnowleopard ssh qasnowleopard.txcorp.com
alias qaubuntu ssh qaubuntu.txcorp.com
alias oxygen ssh oxygen.txcorp.com
alias tatanka ssh krugersc@129.244.40.23
alias loki ssh -X -t cmodws29.psfc.mit.edu  ssh loki.psfc.mit.edu
alias mcs ssh krugers@login.mcs.anl.gov
alias tulip ssh coe0102@tulip.cray.com

