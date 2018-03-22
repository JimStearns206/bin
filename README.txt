Bash script utilities for JimStearns206
Maintained on github.
Includes home dot-files for bash and vi 
  Convention: Place symbolic links in ~ to these files in bin or bin/vim
  Files: .bash_profile, .bashrc, .exrc. vim/_vimrc 
  Commands:
    cd

    # If on MacOS:
    # If ~/.bash_profile doesn't exist:
    ln -s bin/bash_profile .bash_profile
    # else add source ~/bin/bash_profile to end of .bash_profile
    ln -s bin/bashrc .bashrc

    ####
    # Any Unix (MacOS, Ubuntu, CentOS):
    ln -s bin/exrc .exrc
    mkdir ~/Teebags

    # Use :version to determine where vim looking for rc file
    ln -s bin/vim/_vimrc .ideavimrc # for PyCharm
    ln -s bin/vim/_vimrc .vimrc     # for vim
    # End Any Unix
    ####

    # If on Ubuntu (it defines a useful .bashrc that pulls in .bash_aliases:
    ln -s bin/bashrc .bash_aliases
    # To activate:
    source ~/.bashrc

    # If on CentOS7, both .bash_profile and .bashrc exist.
    # Add references to bin/bash_profile and bin/bashrc in those files.
    # For example:

    ## If my GitHub bin repo has been cloned into ~/bin, pull in bin/bash_profile
    #if [ -f ~/bin/bash_profile ]; then
    #    . ~/bin/bash_profile
    #fi

    # Windows:
    cd %HOME%
    mklink /H .ideavimrc bin\vim\_vimrc

  See bin/vim/README.md for configuring IdeaVim inside PyCharm.
