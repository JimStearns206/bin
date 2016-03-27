##
# NO LONGER: Alias - for NOAA MARPLOT work (32-bit Python.org's Python 2.7.8:
# Use VM for NOAA work. Default to Python 3 here.
##
##alias python='/Library/Frameworks/Python.framework/Versions/2.7/bin/python2.7-32'
##echo "N.B: Aliasing python to python.org's 32-bit 2.7"

alias python='python3'
echo "N.B: Aliasing python to python3 64-bit"

##
# PATH
##
if [ -d ~/bin ]; then
    export PATH="~/bin:${PATH}"
    echo "Added ~/bin to PATH"
else
    echo "Oops - didn't find ~/bin"
fi
