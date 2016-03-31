#!/bin/bash
VERSIONS="27 35"
BUILDDIR=~/miniconda3/conda-bld

function build {
	for VERSION in $VERSIONS; do
		conda build $1 --python=$VERSION -q
		TARBALL_PATH=`conda build $1 --python=$VERSION --output`
		TARBALL_NAME=`basename $TARBALL_PATH`
		conda convert $TARBALL_PATH -o ${BUILDDIR} --platform=all -q
		for platfrom in "win-32" "win-64" "osx-64" "linux-32" "linux-64"; do
			anaconda upload --force ${BUILDDIR}/$platfrom/${TARBALL_NAME} 
		done
	done
}
function buildall {

	for D in *; do
		if [ -d "${D}" ]; then
		echo "building ${D}"
		build $D	
		fi
	done
}

if [ $# == 0 ]; then
	buildall
else
	for arg in $@; do
		build $arg
	done
fi