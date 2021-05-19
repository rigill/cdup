#!/usr/bin/env bash

dir=.
pwd=$(pwd)

# check first parameter is set
if [ -n "$1" ]; then
  dir="${pwd%$1*}${1}"
fi

# check if directory exists
if [ -d "${dir}" ]; then
  # echo "$dir"
  cd "$dir" || exit
fi
