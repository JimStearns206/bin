##
# PATH
##
if [ -d ~/bin ]; then
    export PATH="~/bin:${PATH}"
    echo "Added ~/bin to PATH"
else
    echo "Oops - didn't find ~/bin"
fi

## 
# Shell prompts and other bash configuration
##

# Just the current directory for shell prompt.
# Default: "\h:\W \u\\$ "
export PS1="[\W]$ "

# Vi mode
export EDITOR=vi
set -o vi

###
# Aliases for james.stearns@noaa.gov on NWFSC MacBook Pro
###
alias sqlplus='~/bin/oracle_sqlplus/instantclient_12_2/sqlplus'
alias 12rb='cd ~/FramDataRepos/auv/12redblue'

