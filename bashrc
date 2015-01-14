##
# Alias - for NOAA MARPLOT work (32-bit Python.org's Python 2.7.8:
##
alias python='/Library/Frameworks/Python.framework/Versions/2.7/bin/python2.7-32'
echo "N.B: Aliasing python to python.org's 32-bit 2.7"

##
# PATH
##
if [ -d ~/bin ]; then
    export PATH="~/bin:${PATH}"
    echo "Added ~/bin to PATH"
else
    echo "Oops - didn't find ~/bin"
fi
