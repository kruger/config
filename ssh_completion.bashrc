__complete_ssh_host() {
    local KNOWN_FILE=~/.ssh/known_hosts
    if [ -r $KNOWN_FILE ] ; then
        local KNOWN_LIST=`cut -f 1 -d ' ' $KNOWN_FILE | cut -f 1 -d ',' | grep -v '^[0-9[]'`
    fi

    local CONFIG_FILE=~/.ssh/config
    if [ -r $CONFIG_FILE ] ; then
        local CONFIG_LIST=`awk '/^Host [A-Za-z]+/ {print $2}' $CONFIG_FILE`
    fi

    local PARTIAL_WORD="${COMP_WORDS[COMP_CWORD]}";

    COMPREPLY=( $(compgen -W "$KNOWN_LIST$IFS$CONFIG_LIST" -- "$PARTIAL_WORD") )

    return 0
}

complete -F __complete_ssh_host ssh
complete -f -F __complete_ssh_host scp
