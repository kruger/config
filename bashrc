
# This is for mac
export BASH_SILENCE_DEPRECATION_WARNING=1


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export PATH="/usr/local/texlive/2018/bin/x86_64-darwin:${PATH}"
export PATH="/usr/local/homebrew/bin/:${PATH}"
export PATH="$HOME/opt/anaconda3/bin/:${PATH}"
export PATH="/usr/local/homebrew/opt/coreutils/libexec/gnubin/:${PATH}"

export SCRATCH=/scr_gabrielle/kruger
alias tmpdir="cd $SCRATCH"

source $HOME/config/global.bashrc

export SPACK_ROOT=$HOME/spackroot/spack
export PATH=${SPACK_ROOT}/bin:${PATH}
#alias spackinit='source $HOME/dgFramework/apolloall/share/apollo.sh'


# Defines `j` and `jc` to guess which directory to go to
[ -f /usr/local/homebrew/etc/profile.d/autojump.sh ] && . /usr/local/homebrew/etc/profile.d/autojump.sh

# Something in my global.bashrc or aliases.bashrc messes up the completion here 
#  so make sure this is after those sourcings
[[ -r "/usr/local/homebrew/etc/profile.d/bash_completion.sh" ]] && 
    .  "/usr/local/homebrew/etc/profile.d/bash_completion.sh"

# Fuzzy finder settings -- includes completions
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Source spack setting files
for file in "$SPACK_ROOT/share/spack/spack-completion.bash"
do
    if [[ -f "$file" ]]
    then
        source "$file"
    fi
done

# Fancy prompt
eval "$(starship init bash)"

# Direnv -- customized directory settings
eval "$(direnv hook bash)"
