#!/bin/bash

#  The script sets up symlinks for the files in repository
#+ in the home directory of the user who runs the script.

wd="$(dirname "$0")"

ls "$wd" | egrep -v "(setup.sh|README.md)" | while read filename; do
    ln -s "$(pwd)"/"$wd"/"$filename" "$HOME"/."$filename"
done
