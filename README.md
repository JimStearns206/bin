# VIM Files for Jim Stearns

Intended for use with Vim on Windows and Mac, and IdeaVim in JetBrains IDEs such as PyCharm.

(Not planning to use GVim on Windows, nor have I installed MacVim). So Vim, and IdeaVim.)

__Convention: on repo text files are stored with unix/OS X line terminator convention, not Windows (LF, not CRLF)__ 

Implication:
	 
* On MacOS/Linux: no need to make any setting, but this explicit one is what's expected:
	 
		```git config core.autocrlf input```
		
		Git makes sure repo objects are written with LF.
		
* On Windows:

		```git config core.autocrlf true```
		
		Git converts commits to LF, writes out to working file with CRLF.
		
(For more details: [Mind the end of your line](http://adaptivepatchwork.com/2012/03/01/mind-the-end-of-your-line/))

_Assumption: This directory git cloned to ~/vimfiles._

_Assumption: The same vim configuration file can be used for both vim and IdeaVim_

## Environment Variables To Define

* Windows Only: Vim assumes %HOME% has been defined to be ~. Simplest way:

	```set %HOME%=%USERPROFILE%```

## Symbolic Links To Establish

* Set up Vimrc 
	* 	MacOS/Unix: looks for ~/.vimrc
		
		```
		cd ~
		ln -s vimfiles/_vimrc .vimrc
		```
	* Windows: Looks for ~/_vimrc 

		```
		cd %HOME%
		mklink /H _vimrc vimfiles\_vimrc
		```

* Set up Ideavimrc
	* Looks for ~/.ideavimrc
	* MacOs/Unix: 
		
		```
		cd ~
		ln -s vimfiles/_vimrc .ideavimrc
		```
		
	* Windows:

		```
		cd %HOME%
		mklink /H .ideavimrc vimfiles\_vimrc
		````
* IdeaVim Configuration Inside PyCharm

	* For copy/paste to work outside IDE, let IDE control Cntl+V/Cntl+C
		* Settings/Other Settings/Vim Emulation,
			let IDE control those two keystroke sequences.
		* Details: http://askubuntu.com/questions/568662/ctrl-v-and-ctrl-c-doesnt-work-in-intellij-idea-14-0-2

