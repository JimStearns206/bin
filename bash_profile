#!/bin/bash
#
# bash profile for Jim Stearns and for Jim Stearns as VM user.
echo "Running bin/bash_profile ..."

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
    
    # Adding path to allow ipython nbconvert to pdf. 
    pdflatex_path=/usr/local/texlive/2014/bin/x86_64-darwin/
    if [ -d $pdflatex_path ]; then
        PATH=${PATH}:${pdflatex_path}
        echo "Added path to find pdflatex for ipython nbconvert to PDF"
    else
        echo "Did not find path for pdflatex; ipython nbconvert to pdf operations may fail"
        echo "Expected path = $pdflatex_path"
    fi

    export PATH

    # Allow easy access to mysql commands:
    PATH="/usr/local/mysql/bin:$PATH"
    export PATH
    echo "Modified PATH = '$PATH'"
else
    echo "Not user jimstearns; skipping some PATH customizations"
fi

##
# Aliases
##
# Show trailing asterisk or slash to indicate file type.
alias ls='ls -F'
# Can't break this habit formed at HP LSD in the 80's.
alias ll='ls -l'
# For listing metadata of a large MP4 file, typically uploaded from TiVo
alias tivometa='exiftool -api largefilesupport=1 '

# List hidden .files in Finder, or not
# Source: http://ianlunn.co.uk/articles/quickly-showhide-hidden-files-mac-os-x-mavericks/

alias finderShow='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

alias finderHide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Only set if user is jimstearns. Don't clutter and confuse Mac VMs.
if [ "$(whoami)" = "jimstearns" ]; then
    ##
    # For Learning base directory
    ##
    alias learning='cd ~/GoogleDrive/Learning'

    ##
    # For Kaggle Competitions
    ##
    alias kaggle='cd ~/GoogleDrive/Learning/Challenges/Kaggle'

    ##
    # For current courses
    ##

    ##
    # For completed courses
    ##
    alias uwds1='cd ~/GoogleDrive/Learning/Courses/UWPCE-DataScience/Course1_Intro'
    alias uwds2='cd ~/GoogleDrive/Learning/Courses/UWPCE-DataScience/Course2_Methods'
    alias uwds3='cd ~/GoogleDrive/Learning/Courses/UWPCE-DataScience/Course3_DataAtScale'

    # Johns Hopkins Data Science on Coursera
    alias jhds='cd ~/GoogleDrive/Learning/Courses/JohnsHopkinsDataScience'
    alias jhds5='cd ~/GoogleDrive/Learning/Courses/JohnsHopkinsDataScience/5_ReproducibleResearch'
    alias jhds6='cd ~/GoogleDrive/Learning/Courses/JohnsHopkinsDataScience/6_StatisticalInference'
    echo "Set aliases for course work paths"

    ##
    # For PyData 2015, Seattle
    ##
    alias pydata='cd ~/GoogleDrive/Learning/Courses/PyData2015Seattle'
fi

