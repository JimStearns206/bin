# Need not be run as sudo: this installs in local build tree.

# This script builds DrawTile in build/lib.macosx-10.6-intel-2.7
# It copies the dynamic libraries to the same directory,
# modifying the library references in the libraries and DrawTile.so 
# to work in that context.

##
# 1. Build DrawTile.so
#	Current status of mac version of setup.py script:
#	Hard-coded to build 10.8 version.
#	Tested on 10.8, 10.9, and 10.10
##

function osxVer()
{
        prodVer=$(sw_vers -productVersion)
        # "return" (echo) digitsB4FirstPeriod.digitsAfterFirstPeriod
        IFS="."
        verArray=($prodVer)
        echo "${verArray[0]}.${verArray[1]}"
}
ver=$(osxVer)
echo "Ver is ${ver}"
if [ $ver == "10.8" ]; then
        echo "OS X Mountain Lion - supported"
elif [ $ver == "10.9" ]; then
        echo "OS X Mavericks - supported!"
elif [ $ver == "10.10" ]; then
        echo "OS X Yosemite - supported!"
else
        echo "Unrecognized OS X version"
        exit
fi

# Force rebuild by removing build tree
rm -rf build

# Setup.py's extra_link_args don't appear to get to the link step.
# Specify frameworks for linker's benefit
export LD=c++
frameworkParms="-framework GDAL -framework PROJ -framework GEOS -framework UnixImageIO"
export LDSHARED="${LD}    -g -bundle -undefined dynamic_lookup -arch i386 ${frameworkParms}"

# Note: "build", not "install". Latter involves copy to system directories -
# and sudo.
python setup.py build

echo "Used this line for LDSHARED: $LDSHARED"
