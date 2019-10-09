#!/usr/bin/env bash
#
# Package WoW addon using the BigWigs Packager
# This allows us to keep retail and classic versions in the same repo,
# since the vast majority of the code is the same.
# 
# -d -- Skip uploading
# -z -- Skip zip file creation
# -r -- Directory to copy files
# -g -- Version to release for
# -e -- "noLib" build (we keep a local copy so we're not constantly downloading them)

build_retail="true"
build_classic="true"

OPTIND=1
while getopts "cr" opt; do
    case $opt in
        c) 
            build_classic="true"
            build_retail="false"
            ;;
        r) 
            build_retail="true"
            build_classic="false"
            ;;
    esac
done

addon="FactionFriend_Reborn"

if [[ "${build_classic}" == "true" ]]; then
    # Classic
    echo "Building Classic version"
    classic="/home/dragonwolf/Games/diablo-iii/drive_c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns/"
    curl -s https://raw.githubusercontent.com/BigWigsMods/packager/master/release.sh | bash -s -- -d -e -z -r "$classic" -g 1.13.2
    echo "Copying local Libs"
    cp -r ../Ace3 "$classic$addon/Libs"
fi

if [[ "${build_retail}" == "true" ]]; then
    echo "Building Retail version"
    # Retail
    retail="/home/dragonwolf/Games/diablo-iii/drive_c/Program Files (x86)/World of Warcraft/_retail_/Interface/AddOns/"
    curl -s https://raw.githubusercontent.com/BigWigsMods/packager/master/release.sh | bash -s -- -d -e -z -r "$retail"
    echo "Copying local Libs"
    cp -r ../Ace3 "$retail$addon/Libs"
fi