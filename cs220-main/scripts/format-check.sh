#!/usr/bin/env bash

set -e

# Ignore file names in ./src that start with S
declare -a files

for entry in "src"/*; do
    if [[ $entry != src/S* ]]
        then files+=($entry)
    fi
done

# format
brittany --write-mode=inplace src/*.hs app/*.hs test/*.hs -c
brittany --write-mode=inplace "${files[@]}" app/*.hs test/*.hs -c

# lint
hlint .
hlint "${files[@]}" app/*.hs test/*.hs
