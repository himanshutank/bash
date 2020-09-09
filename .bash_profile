set -o vi

alias sc='cat ~/.ssh/config'

complete -f -d -W "$(grep '[Hh]ost ' ~/.ssh/config | grep -v '*' | awk '{print $2}')" ssh scp

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
