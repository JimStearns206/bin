#!/bin/bash
#
# bash profile for Jim Stearns and for Jim Stearns as VM user.

# Reference the bash script invoking even for batch jobs.
if [ -f ~/.bashrc ]; then
	echo "Loading ${HOME}/.bashrc"
	source ~/.bashrc
fi

##
# Environment Variables
# Put all environment variables here. This is read in at shell login.
##

# MacPorts Installer addition on 2014-11-08_at_13:38:26: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# -- PATH --
# Only set if user is jimstearns. Don't clutter and confuse Mac VMs.
if [ "$(whoami)" = "jimstearns" ]; then
    echo "Adding path entries for user jimstearns"
    # added by Anaconda 1.8.0 installer
    ## While working on NOAA MARPLOT, don't use anaconda:
    ##export PATH="/Users/jimstearns/anaconda/bin:$PATH"
    ## Or Python3.4
    # Setting PATH for Python 3.4
    # The original version is saved in .bash_profile.pysave
    ##PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
    
    echo "NOT setting up Python anaconda or 3.4 in PATH (while MARPLOTing)"

    # Setting PATH for Python 2.7 using python.org Python.
    PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
    export PATH

    # Allow easy access to mysql commands:
    PATH="/usr/local/mysql/bin:$PATH"
    export PATH
    echo "Modified PATH = '$PATH'"
else
    echo "Not user jimstearns; skipping some PATH customizations"
fi

# Just the current directory for shell prompt.
# Default: "\h:\W \u\\$ "
export PS1="[\W]$ "

# Vi mode
export EDITOR=vi
set -o vi

##
# Aliases
##
# Show trailing asterisk or slash to indicate file type.
alias ls='ls -F'
# Can't break this habit formed at HP LSD in the 80's.
alias ll='ls -l'

# List hidden .files in Finder, or not
# Source: http://ianlunn.co.uk/articles/quickly-showhide-hidden-files-mac-os-x-mavericks/

alias finderShow='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

alias finderHide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Only set if user is jimstearns. Don't clutter and confuse Mac VMs.
if [ "$(whoami)" = "jimstearns" ]; then
    ##
    # For current courses
    ##
    alias uwds1='cd ~/GoogleDrive/Learning/Courses/UWPCE-DataScience/Course1_Intro'
    alias uwds2='cd ~/GoogleDrive/Learning/Courses/UWPCE-DataScience/Course2_Methods'
    alias uwds3='cd ~/GoogleDrive/Learning/Courses/UWPCE-DataScience/Course3_DataAtScale'
    # Finished adapting your PATH environment variable for use with MacPorts.

    # Johns Hopkins Data Science on Coursera
    alias jhds='cd ~/GoogleDrive/Learning/Courses/JohnsHopkinsDataScience'
    alias jhds5='cd ~/GoogleDrive/Learning/Courses/JohnsHopkinsDataScience/5_ReproducibleResearch'
    alias jhds6='cd ~/GoogleDrive/Learning/Courses/JohnsHopkinsDataScience/6_StatisticalInference'
    echo "Set aliases for course work paths"
fi
