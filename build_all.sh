#!/bin/bash
VERSIONS="27 33 34"
BUILDDIR=~/miniconda3/conda-bld
for D in *; do
	if [ -d "${D}" ]; then
	echo "building ${D}"
	for VERSION in $VERSIONS; do
		conda build ${D} --python=$VERSION -q
		TARBALL_PATH=`conda build ${D} --python=$VERSION --output`
		TARBALL_NAME=`basename $TARBALL_PATH`
		conda convert $TARBALL_PATH -o ${BUILDDIR} --platform=all -q
		for platfrom in "win-32" "win-64" "osx-64" "linux-32" "linux-64"; do
			anaconda upload --force ${BUILDDIR}/$platfrom/${TARBALL_NAME} 
		done
	done
	fi
done