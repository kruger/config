#					Networking completion
#					Automatically setup hosts.

 set hosts=(volt.txcorp.com dipole.txcorp.com enrico.txcorp.com multipole.txcorp.com fusion.txcorp.com nimrod.txcorp.com iter.txcorp.com oxygen.txcorp.com qalion.txcorp.com qasnowleopard.txcorp.com qaubuntu.txcorp.com sandybridge.txcorp.com ivy.txcorp.com haswell.txcorp.com plasma.txcorp.com)
set noglob
if ( ! $?hosts ) set hosts
set hosts=($hosts)

# Hosts where I have a different login name:
set hosts=($hosts skruger@seaborg.nersc.gov skruger@hopper.nersc.gov skruger@bassi.nersc.gov skruger@jacquard.nersc.gov skruger@franklin.nersc.gov skruger@carver.nersc.gov hydra.gat.com skruger@euclid.nersc.gov jaguar.ccs.ornl.gov krugersc@129.244.40.23)


#					Complete on hosts
complete ftp 'p/1/$hosts/'
complete ywho  'n/*/$hosts/'
complete rsh	p/1/\$hosts/ c/-/"(l n)"/   n/-l/u/ N/-l/c/ n/-/c/ p/2/c/ p/*/f/
complete ssh	p/1/\$hosts/ c/-/"(l n)"/   n/-l/u/ N/-l/c/ n/-/c/ p/2/c/ p/*/f/
complete rlogin 	p/1/\$hosts/ c/-/"(l 8 e)"/ n/-l/u/
complete telnet 	p/1/\$hosts/ p/2/x:'<port>'/ n/*/n/
complete scp "c,*:/,F:/," "c,*:,F:$HOME," 'n/*/$hosts/:/'


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
###
## Common machines
#
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
alias vsb  ssh -t dipole.txcorp.com ssh -A -t sandybridge.txcorp.com
alias vivy ssh -t dipole.txcorp.com ssh -A -t ivy.txcorp.com
alias vphi ssh -t dipole.txcorp.com ssh -A -t phi.txcorp.com
alias voxy ssh -t dipole.txcorp.com ssh -A -t oxygen.txcorp.com
alias vhaswell ssh -t dipole.txcorp.com ssh -A -t haswell.txcorp.com
alias vphi ssh -t dipole.txcorp.com ssh -A -t phi.txcorp.com
alias ivy ssh ivy.txcorp.com
alias phi ssh phi.txcorp.com
alias haswell ssh haswell.txcorp.com
alias plasma ssh plasma.txcorp.com
alias qalion ssh qalion.txcorp.com
alias qasnowleopard ssh qasnowleopard.txcorp.com
alias qaubuntu ssh qaubuntu.txcorp.com
alias oxygen ssh oxygen.txcorp.com
alias tatanka ssh krugersc@129.244.40.23
alias loki ssh -X -t cmodws29.psfc.mit.edu  ssh loki.psfc.mit.edu

