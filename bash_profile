#!/bin/bash
#
# bash profile for Jim Stearns and for Jim Stearns as VM user.
echo "Running bin/bash_profile ..."

# Reference the bash script invoking even for batch jobs.
if [ -f ~/.bashrc ]; then
	echo "Loading ${HOME}/.bashrc"
	source ~/.bashrc
fi

personal_logins="jimstearns jimstearns206 js206 jimstearns206test js206t"

##
# Environment Variables
# Put all environment variables here. This is read in at shell login.
##
export NLTK_DATA=~/nltk_data

# MacPorts Installer addition on 2014-11-08_at_13:38:26: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# -- PATH --
# Only set if user is jimstearns. Don't clutter and confuse Mac VMs.
if echo "${personal_logins}" | grep -w "$(whoami)" >/dev/null; then
    echo "Adding path entries for $(whoami), one of personal logins of jim stearns"
    
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

# List what processes are using NOAA MARPLOT server port
alias noaaport='lsof -i tcp:56677'

# Only set if user is jimstearns. Don't clutter and confuse Mac VMs.
if [ "$(whoami)" = "jimstearns" ]; then
    ##
    # For Learning base directory
    ##
    alias cd_learning='cd ~/NAS_file/Learning'

    ##
    # For Kaggle Competitions
    ##
    alias kaggle='cd ~/NAS_file/Learning/Challenges/Kaggle'

    # Kaggle intracranial EEG Seizure Prediction (from NeuroVista data)
    alias ieeg='cd ~/NAS_file/Learning/Challenges/Kaggle/IeegSeizurePrediction'

    ##
    # For General Fusion Challenge at Innocentive (Dec2015-Mar2016)
    # (Put on One Drive because data too big for my almost-full 100GB Google Drive.
    ##
    alias fusion='cd ~/NAS_file/Learning/Challenges/GeneralFusion'

    # For current courses
    ##

    ##
    # For completed courses
    ##
    alias uwds1='cd ~/NAS_file/Learning/Courses/UWPCE-DataScience/Course1_Intro'
    alias uwds2='cd ~/NAS_file/Learning/Courses/UWPCE-DataScience/Course2_Methods'
    alias uwds3='cd ~/NAS_file/Learning/Courses/UWPCE-DataScience/Course3_DataAtScale'

    # Johns Hopkins Data Science on Coursera (Did first 6 (of 10)).
    alias jhds='cd ~/NAS_file/Learning/Courses/JohnsHopkinsDataScience'
    alias jhds5='cd ~/NAS_file/Learning/Courses/JohnsHopkinsDataScience/5_ReproducibleResearch'
    alias jhds6='cd ~/NAS_file/Learning/Courses/JohnsHopkinsDataScience/6_StatisticalInference'
    echo "Set aliases for course work paths"

    ##
    # For PyCon 2016, Portland
    ##
    alias pycon='cd ~/NAS_file/Learning/Conferences/PyCon2016'

    ##
    # For PuPPy ATOM studies of Kaggle winners
    alias cdrtwh='cd /Volumes/file/CldUnenc/Learning/MeetUps/PuPPy-ATOM/noaa-right-whale-recognition'

    ##
    # For PuPPy/ATOM meeting Kaggle repro's
    ##
    # "dwr": deepsense-whales-repro
    alias cd-dwr='cd ~/NoCloudDrive/Learning/Meetups/ATOM/deepsense-whales-repro'
fi


# added by Anaconda3 4.0.0 installer
export PATH="/Users/jimstearns/anaconda/bin:$PATH"

##
# Your previous /Users/jimstearns/.bash_profile file was backed up as /Users/jimstearns/.bash_profile.macports-saved_2016-11-19_at_23:43:44
##
# Setting PATH for Python 3.6
# MacPorts Installer addition on 2016-11-19_at_23:43:44: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
# added by Anaconda3 4.3.1 installer
export PATH="/Users/jimstearns/anaconda/bin:$PATH"
