#!/usr/bin/env sh
pushd $(dirname "$0")

version=$1

if [[ "$version" == "" ]];
then
    echo Usage: $(basename "$0") version
    exit -1
fi

rm -r utf8rewind

wget https://bitbucket.org/knight666/utf8rewind/downloads/utf8rewind-$version.zip
unzip utf8rewind-$version.zip
rm utf8rewind-$version.zip
mv utf8rewind-$version utf8rewind

# Clean up downloaded package
cd utf8rewind
rm -rf .hg* .editorconfig *.gyp *.py *.doxyfile build dependencies documentation testdata tools
rm -rf source/{documentation,helpers,performance,properties,tests}

popd
