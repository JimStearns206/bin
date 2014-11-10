#!/bin/bash
# Multi-Line Comment:
: '
After py2app has created an OS X application bundle MARPLOT_server.app,
run this post-processing script to strip the 64-bit version of python
and to add necessary dynamic libraries.

Notes:

py2app is behaving differently after move to Python2.7 and use of downloaded
macholib.
* py2app isn’t automatically pulling MrSID dynamic libraries into the bundle. I have
to include them explicitly using the options : framework.
* py2app, and macholib in particular, isn’t updating the dynamic library references
to work in the application bundle context. 

The expected change in py2app behavior to create a completely standalone bundle
was not as risk-free as hoped for. Yes, by specifying a python.org, py2app now
includes python in MARPLOT_server.app/Contents/MacOS, but the executable included
is “fat” - it contains both the i386 and 64-bit versions.

There are likely ways to sculpt py2app to address these issues. But the
documentation is meager, and even Google/StackOverflow is relatively silent.

Therefore, I will for the time being develop a bash script that post-processes the
dist/MARPLOT_server.app bundle with these steps:
1. Strip (via “lipo”) the 64-bit version of python from the python executable in
dist/MARPLOT_server.app/Contents/MacOS.
2. Use install_name_tool to fix up dynamic library references in DrawTile.so and the
MrSID libraries to work in the context of the application bundle.
'

bundleBaseDir="dist/MARPLOT_server.app/Contents"
if [ ! -d "$bundleBaseDir" ]; then
    echo "This script must be run from the Subversion source base directory"
    echo "Could not find application bundle directory '$bundleBaseDir'."
    exit 1
fi

svnBaseDir=$(pwd)

function strip64BitVersion() {
    funcName="strip64BitVersion"

    if [ $# -ne 2 ]; then
        echo "${funcName} Error: two parameters required."
        exit 1
    fi

    path=$1
    fileToStrip=$2

    if [ ! -d "$path" ]; then
        echo "${funcName} Error: can not find supplied directory '$path'"
        echo "(PWD=$(pwd))"
        exit 1
    fi

    pathToFile=${path}/${fileToStrip}

    if [ ! -f ${pathToFile} ]; then
        echo "${funcName} Error: could not find file '${fileToStrip}' in '$path'."
        exit 1
    fi

    # Performing a "file" on a file with 64-bit version will contain a line like:
    # "<file> (for architecture x86_64):    Mach-O 64-bit executable x86_64"
    if [[ $(file ${pathToFile}) != *x86_64* ]]; then
        echo "${funcName}: File '$pathToFile' doesn't contain a 64-bit version; no lipo needed."
        return
    else
        mv ${pathToFile} ${pathToFile}.fat
        lipo -thin i386 -output ${pathToFile} ${pathToFile}.fat
        echo "${funcName}: File binary types after lipo: $(file ${pathToFile})"
    fi
}

# 1. Strip 64-bit version python from python executable included in bundle.

cd ${svnBaseDir}
strip64BitVersion ${bundleBaseDir}/MacOS python

# 2. Use install_name_tool to fix up dynamic library references in DrawTile.so and the
#   MrSID libraries to work in the context of the application bundle.


# Directories
# 
cd ${svnBaseDir}
mrSidLibDir=dist/MARPLOT_server.app/Contents/Frameworks
if [ ! -d ${mrSidLibDir} ]; then
    echo "Error: can't find directory holding MrSID raster libraries: '$mrSidLibDir'."
    exit 1
fi

drawTileSoDir=dist/MARPLOT_server.app/Contents/Resources/lib/python2.7/lib-dynload
if [ ! -d ${drawTileSoDir} ]; then
    echo "Error: can't find directory holding DrawTile.so: '$drawTileSoDir'."
    exit 1
fi

# Files
#
drawTileSo=DrawTile.so

geos2=libgeos.2.dylib
geosc1=libgeos_c.1.dylib
ltidsdk9=libltidsdk.9.dylib
tbb=libtbb.dylib

cd ${svnBaseDir}
cd ${drawTileSoDir}
if [ ! -f ${drawTileSo} ]; then
    echo "Error: can't find '$drawTileSo'."
    exit 1
fi

cd ${svnBaseDir}
cd ${mrSidLibDir}
declare -a dylibs=("$geos2" "$geosc1" "$ltidsdk9" "$tbb")
for dylib in "${dylibs[@]}"; do
    if [ ! -f "$dylib" ]; then
        echo "Could not find dynamic library '$dylib'"
        exit 1
    fi
done
cd ${svnBaseDir}

echo "Found DrawTile.so and the MrSID raster libraries in the application bundle."

##
# DrawTile.so
##

# DrawTile.so as built expects MrSID 10.8 libraries in this weird, wrong, directory:
wrongMrSidLibDir="/data/builds/Bob/darwin12.universal.gccA42__default/xt_lib_geos/darwin12.universal.gccA42/Release/src/geos-2.2.3/../../../../dist/darwin12.universal.gccA42/Release/lib"

# 
# drawTileSoDir=dist/MARPLOT_server.app/Contents/Resources/lib/python2.7/lib-dynload
# mrSidLibDir=dist/MARPLOT_server.app/Contents/Frameworks
# Which means libs can be found relative to DrawTile.so using this path:
#relPathToLibs="@loader_path/../../../../Frameworks"
# But this is simpler, and the one used by py2app to find frameworks it kens:
relPathToLibs="@executable_path/../Frameworks" 

cd ${svnBaseDir}
cd ${drawTileSoDir}

function changeLibPath() {
    funcName="changeLibPath"
    if [ $# -ne 3 ]; then
        echo "$funcName: Error: Need exactly three parameters, not $#"
        exit 1
    fi

    fileToChange=$1
    libraryRefToChange=$2
    newPath=$3

    if [ ! -f "$fileToChange" ]; then
        echo "$funcName: Error: Can't find file to change '${fileToChange}'."
        exit 1
    fi

    line=$(otool -L $fileToChange | grep "$libraryRefToChange")
    # Trim any leading spaces
    line=$(echo $line | xargs)
    echo "**DEBUG: line=$line"
    nlines=$(echo $line | wc -l)
    if [ $nlines -eq 0 ]; then
        echo "$funcName: Error: Can't find reference for '$libraryRefToChange' in '$fileToChange'"
        exit 1
    elif [ $nlines -gt 1 ]; then
        echo "$funcName: Confusion: Found more than one ref for '$libraryRefToChange' in '$fileToChange'"
        echo $line
        exit 1
    else
        curPath=${line%%${libraryRefToChange}*}
        echo "old path is '$curPath'"
        # If new path is not an empty string and doesn't end with a slash, add one.
        if [ ! -z "$newPath" ]; then
            case "$newPath" in
            */)
                ;;
            *) 
                newPath="${newPath}/"
                echo "(Added slash separator after new path)"
                ;;
            esac
        fi
        cmd="install_name_tool -change ${curPath}${libraryRefToChange} ${newPath}${libraryRefToChange} ${fileToChange}"
        echo "$funcName: executing '$cmd'"
        eval `$cmd`
    fi
}

# Fix the long-winded absolute directories for these two libraries:

changeLibPath  ${drawTileSo} ${geos2} ${relPathToLibs}
changeLibPath  ${drawTileSo} ${geosc1} ${relPathToLibs}

# Fix the relative references - relative references, no path, don't seem to work.

changeLibPath  ${drawTileSo} ${ltidsdk9} ${relPathToLibs}
changeLibPath  ${drawTileSo} ${tbb} ${relPathToLibs}

##
# Fix loader references in the dylibs to other dylibs in the same directory.
##

cd ${svnBaseDir}

# Version of install_name_tool in /usr/bin gives this error when issuing this command:
# "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr
# /bin/install_name_tool: for architecture x86_64 object:
# libgeos_c.1.dylib malformed object (load command 3 cmdsize not a multiple of 8)"
# So strip the 64-bit version from the library.
strip64BitVersion ${mrSidLibDir} ${geosc1}

# Now adjust the reference path.
changeLibPath  ${mrSidLibDir}/${geosc1} ${geos2} ${relPathToLibs}

# install_name_tool has same problem with libltisdk.9.dylib's 64-bit binary version.
# Strip it.
strip64BitVersion ${mrSidLibDir} ${ltidsdk9}

# Fix the relative references 
changeLibPath  ${mrSidLibDir}/${ltidsdk9} ${tbb} ${relPathToLibs}
