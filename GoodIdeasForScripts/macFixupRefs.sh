# Fix-up references in DrawTile.so in the build directory to dynamic libs.
# Also fix up references in the dynamic libraries to other dylibs in the same directory.
# Assumes that the dynamic libraries are in the same directory as DrawTile.so itself
# Change to the build directory holding the so file and dylib files.
# Expectation: DrawTile.so is in MARPLOT-SVN/Drawtile/${relativeBuildPath},
# and dylibs have been copied there as well.

relativeBuildPath=build/lib.macosx-10.6-intel-2.7
if [ -z "$relativeBuildPath" -o ! -d $relativeBuildPath ]; then
    echo "Could not cd to directory $relativeBuildPath"
    exit 1
fi
cd $relativeBuildPath
echo "PWD=$(pwd)"
echo "Contents: $(ls -l)"

# Early exit if files to be operated upon do not exist in PWD
soFile="DrawTile.so"

if [ ! -f "$soFile" ]; then
    echo "Could not find file '$soFile'"
    exit 1
fi

# Dynamic Libraries, either referenced, or referencing, or both.
geos2="libgeos.2.dylib"
geos_c1="libgeos_c.1.dylib"
ltidsdk="libltidsdk.9.dylib"
tbb="libtbb.dylib"

declare -a dylibs=("$geos2" "$geos_c1" "$ltidsdk" "$tbb")
for dylib in "${dylibs[@]}"; do
    if [ ! -f "$dylib" ]; then
        echo "Could not find dynamic library '$dylib'"
        exit 1
    fi
done

# Assumption: Using the 10.8 MountainLion versions of MrSID libraries,
# not the Mavericks version. 10.8 version eems to work on both 10.8 and 10.9.
##oldDir="/data/builds/Bob/darwin13.universal.clang51__default/xt_lib_geos/darwin13.universal.clang51/Release/src/geos-2.2.3/../../../../dist/darwin13.universal.clang51/Release/lib"

oldDirMtnLion="/data/builds/Bob/darwin12.universal.gccA42__default/xt_lib_geos/darwin12.universal.gccA42/Release/src/geos-2.2.3/../../../../dist/darwin12.universal.gccA42/Release/lib"

echo "OldDir=$oldDir"

##
# DrawTile.so
##

# Fix the long-winded absolute directories for these two libraries:

cmd="install_name_tool -change ${oldDirMtnLion}/${geos2} @loader_path/${geos2} ${soFile}"
echo "Executing: $cmd"
eval `$cmd`

cmd="install_name_tool -change ${oldDirMtnLion}/${geos_c1} @loader_path/${geos_c1} ${soFile}"
echo "Executing: $cmd"
eval `$cmd`

# Fix the relative references - relative references, no path, don't seem to work.

cmd="install_name_tool -change ${ltidsdk} @loader_path/${ltidsdk} ${soFile}"
echo "Executing: $cmd"
eval `$cmd`

cmd="install_name_tool -change ${tbb} @loader_path/${tbb} ${soFile}"
echo "Executing: $cmd"
eval `$cmd`

##
# Fix loader references in the dylibs to other dylibs in the same directory.
##

cmd="install_name_tool -change ${oldDirMtnLion}/${geos2} @loader_path/${geos2}
${geos_c1}"
echo "Executing: $cmd"
eval `$cmd`

# Fix the relative references - this isn't the execution directory.
ltidsdk="libltidsdk.9.dylib"
tbb="libtbb.dylib"
cmd="install_name_tool -change ${tbb} @loader_path/${tbb} ${ltidsdk}"
eval `$cmd`

