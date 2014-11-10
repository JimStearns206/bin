#!/bin/bash

# macCopyMrSidLibs.sh: copy dylib's needed by DrawTile.so to the directory
#	housing DrawTile.so
#	Source lib directory is built on OS X 10.8 (Mountain Lion)
#   Should be run in <SVN-RootDir>/DrawTile

sourceDir=MrSID-Mac/lib-OSX10.8
destDir=build/lib.macosx-10.6-intel-2.7

# Error out if either destDir or sourceDir don't exist
if [ ! -d $sourceDir ]
then
	echo "Error: can't find source directory '$sourceDir'."
	exit
elif [ ! -d $destDir ]
then
	echo "Error: can't find target directory '$destDir'."
	exit
fi

echo "Copying MrSID dylibs built on OS X 10.8 to $destDir"
cmd="cp $sourceDir/*.dylib $destDir"
echo "Executing: $cmd"
eval `$cmd`

ls -l $destDir/*.dylib
