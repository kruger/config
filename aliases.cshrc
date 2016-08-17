#----------------------------------------------------------------------
# Aliases that can be used globally
# See local.cshrc
#----------------------------------------------------------------------
###
## Various listings
#
# F option is to give indication of type of file which is 
#  especially useful for systems without color
# The -v ("version") is to give me that old-time Unix listing instead
#  of that new-fangled user-friendly shit :)
alias l ls -l
alias la ls -la
alias lf 'ls --ignore="*.[om]*"'
alias lm 'ls -la | more'
alias ldir 'ls -l | grep ^d'
alias lss	'ls -la | less'
alias ls 'ls -F -v --color=tty'
alias sl ls
alias lsS	'ls -S' # ls -S sorts by file size, largest files first
alias lsc	'ls -c' # ls -c sorts by change time
alias lst	'ls -t' # ls -t sorts by modification time
alias lsu	'ls -u' # ls -u sorts by last access time
alias lsx	'ls -X' # ls -X sorts alphabetically by entry extension 

###
## Remove and copy 
#
alias cp cp -i
alias rm  newrm.sh
#alias rm 'mv \!$ ~/Desktop/.Trash'
alias rmf '/bin/rm '
alias rmi '/bin/rm -i'
alias rmr '/bin/rm -rf'
alias mkdir mkdir -p

###
##  Make moving around easier.
#
alias cdp='cd -P'
alias std 'echo "cd " $PWD > $HOME/.dirtocd'   # "set dir"
alias ssd 'std; ssh \!$'
alias go 'source $HOME/.dirtocd; /bin/rm $HOME/.dirtocd'
#alias std 'set z\!$=$PWD'  # "set dir"
#alias go 'cd z\!$'
alias .. cd ..
alias - cd -

###
## Archive
#
alias untar tar xf
alias unpack 'untar \!$; gzip \!$; mv \!$.gz'
# find dir -name "*.png" | xargs tar rf dir.tar; bzip2 dir.tar  # make archive of *.png in dir

###
## GnuPG
#
alias gpgshowpublic 'gpg --export --armor fullyionized@gmail.com'
alias encryptfilewkey 'gpg --encrypt-file --recipient "Scott Kruger" \!$'
alias encryptfile 'gpg -c \!$'
alias decryptfile 'gpg \!$'
#alias encryptfile 'gpg -c \!$; mv \!$.gpg \!$'

###
## Vi
#
alias vipr 'vi `$_`'						# vi output of previous command
alias view vim -M 	# I really want read-only
alias vimdiff vim -d
alias gvimdiff gvim -d
alias gvim 'gvim -font "LucidaTypewriter 14"'

###
## Miscellaneous
#
alias grepc 'grep --color="auto"'
alias h history
alias x exit
alias k clear
alias who "who | sort"
alias st set term=vt100
# This removes anything under 1M because they aren't important
#alias dusort 'du -sh * | grep -v "^[0-9]\+\.\?[0-9]k" | sort -n'
alias dusort 'du -s \!* | sort -r -n | awk '"'"'{sum+=$1;printf("%9d %s\n",$1,$2)}'"'"
alias calmonth cal `date '+%m %Y'`
alias mydate `date "+%Y-%m-%d"`
alias lookall 'grep --color \!$ /usr/share/dict/words'
alias showtab cat -t -v -e

###
## Job control
#
alias mps 'ps -aux | sort  +4nr | more'
alias gps 'ps -eaf | grep \!$'
#alias gps 'ps -u kruger | grep \!$'
alias showpi 'procinfo -D -n1'
alias killg 'kill -9 `ps -eaf | grep kruger | grep \!$ | cut -f5 -d" " | tr "\012" " "`'
alias killp 'ps -ef|grep \!$ |cut -c 10-15|xargs kill'

###
# Find files
#
alias ffind 'find . -name \*\!*\* -print' # To find all links
alias flink 'find . -type l' 			# To list all directories and subdirectories:
alias fdir 'find . -type d -print' 		# To skip hidden directories:
alias fdir2 "find . \( -name '.*' -prune \) -o \( -type d -print \)"
#Searches for the file named "in", prints it, and then greps it for "chi_pll"
# find . -name in -print -exec grep chi_pll {} ;

###
## Add to environment variables
#
alias addpath 'source $HOME/config/addpath.csh'
alias addpypath 'source $HOME/config/addpypath.csh'

###
## Documentation
#
alias vinfo 'vi -c Info \!$' 			            # Requires info.vim plugin
alias infoman 'info --subnodes --output - \!$ | less' # Because info really, really sucks

###
## Mail
#
alias mutt 'screen -c $HOME/.screenmutt'

###
## Network
#
alias ssh ssh -Y -A
alias scp scp -r
alias rsync 'rsync -ravze ssh'
alias mapus 'nmap -F "192.168.1.*"'
alias nscan 'nmap -sT \!$'
alias netmachine 'netstat -ple'
alias netports 'netstat -nape --inet'
alias established 'netstat -a | grep ESTABLISHED'
alias sshproxy 'ssh -ND 9999 -p 39305 kruger@kinetic.physics.usu.edu'
alias voltproxy 'ssh -ND 9999 volt.txcorp.com'

###
## Printing/Graphics
#
alias lp lpr
alias pp 'enscript -2r -p \!$.ps \!$'
alias dvips 'dvips -t letter'
alias eps2jpg 'convert -quality 100 \!$.eps \!$.jpg'
alias ps2jpg 'convert -crop 0x0 -quality 100 \!$.ps \!$.jpg'
# Linux system often have something like this anyway:
alias man2ps 'man -t \!$ > \!$.ps'
alias man2txt 'man \!$ | col -b > \!$.txt'

###
## Linux rpm aliases
#
alias rpmq 'rpm -q -il' 			# List all install rpm packages
alias rpmall 'rpm -qa' 	 			# List all rpm packages
alias rpmfile 'rpm -qf \!$'			# what package owns a file: (e.g., rpm -qf /bin/rm)
alias rpmpkg 'rpm -qpi \!$' 			# To find info about an discovered rpm:
alias rpmpkglist 'rpm -qpl \!$'		# To see what a package installs
alias rpmreq 'rpm -q --requires \!$' 	# list files/packages that package needs
alias rpmwhat 'rpm -q --whatrequires \!$' # list packages that need package

###
## X-Windowing Stuff
#
alias sdc setenv DISPLAY colt.saic.com:0
alias gvi gvim 
alias svi 'screen -t \!$ 1 vim \!$'
alias xdvi 'xdvi -hush'
alias xmgrace 'xmgrace -nxy'
alias tec tecplot -showpanel
alias mpaa mplayer -vo aa # Run mplayer in ascii mode :)

###
## Programming
#
alias valgrindm '/usr/local/valgrind/bin/valgrind --tool=memcheck --leak-check=yes \!$' 
alias mkae make
alias makel 'make >& out; less out; rm out'
alias lnmake 'ln -s make_includes/make_`uname`.inc make.inc'
#alias lnmake 'ln -sf makefile_`uname` makefile'
alias vucom  "grep ^! nimrod.in | sed 's/\\\!//g'"
alias vuend  "tail -18 nimrod.out"
alias gn 'grep \!$ nimrod.in'

###
## SVN
#
alias svnoutofdate 'svn status -uv | grep \*'
alias svngetc 'svn cat \!$ > C\!$'
#alias svngetr 'svn cat -r \!$1 \!$2 > \!$1.\!$2'
alias svngetr 'echo \!$1 \!$2'
alias svnfiles 'svn status  |& grep -v \? | grep -v "Performing status" | grep -v ^X'
alias notinsvn 'svn status  |& grep \?'

# How to get svn to work properly
#svn propset svn:eol-style native */*.{nml,txt,sh,pre,in}
#svn propset svn:keywords "Author Date Id Revision" */*.{nml,txt,sh,pre,in}

###
## HDF5
#
alias h5header 'h5dump --header'
alias h5lr 'h5ls -r'
alias h5la 'h5ls -rv'
alias h5dds 'h5dump -d'