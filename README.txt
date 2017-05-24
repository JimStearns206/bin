Bash script utilities for JimStearns206
Includes home dot-files for bash and vi 
  Convention: Place symbolic links in ~ to these files in bin
  Files: .bash_profile, .bashrc, .exrc. 
  Commands:
    ln -s bin/bash_profile .bash_profile
    # If on MacOS:
    ln -s bin/bashrc .bashrc
    # If on Ubuntu (it defines a useful .bashrc that pulls in .bash_aliases:
    ln -s bin/bashrc .bash_aliases
    ln -s bin/exrc .exrc
    mkdir ~/Teebags
    source ~/.bash_profile
Maintained on github.
