#!/bin/bash

for D in *; do
    if [ -d "${D}" ]; then
        echo "building ${D}"
        conda build --py 2.7 --py 3.4 --py 3.5 ${D}
    fi
done