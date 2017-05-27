Bash script utilities for JimStearns206
Maintained on github.
Includes home dot-files for bash and vi 
  Convention: Place symbolic links in ~ to these files in bin or bin/vim
  Files: .bash_profile, .bashrc, .exrc. vim/_vimrc 
  Commands:
    cd
    ln -s bin/bash_profile .bash_profile
    # If on MacOS:
    ln -s bin/bashrc .bashrc
    # If on Ubuntu (it defines a useful .bashrc that pulls in .bash_aliases:
    ln -s bin/bashrc .bash_aliases
    ln -s bin/exrc .exrc
    mkdir ~/Teebags
    source ~/.bash_profile

    # MacOS or Linux:
    ln -s bin/vim/_vimrc .ideavimrc
    # Windows:
    cd %HOME%
    mklink /H .ideavimrc bin\vim\_vimrc

  See bin/vim/README.md for configuring IdeaVim inside PyCharm.
