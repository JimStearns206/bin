# VIM Files for Jim Stearns

Intended for use with Vim on Windows and Mac, and IdeaVim in JetBrains IDEs such as PyCharm.

(Not planning to use GVim on Windows, nor have I installed MacVim). So Vim, and IdeaVim.)

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
		ln -s .vimrc vimfiles/_vimrc
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
		ln -s .ideavimrc vimfiles/_vimrc
		```
		
	* Windows:

		```
		cd %HOME%
		mklink /H .ideavimrc vimfiles\_vimrc
		````