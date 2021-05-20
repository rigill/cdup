#!/usr/bin/env bash

version="0.0.3"

dir=.
pwd=$(pwd)

# usage info
usage() {
  cat <<EOF
  Usage: cdup [directory]
  Options:
    -u, --update            Update cdup
    -v, --version           Output version
    -h, --help              This message.
    --                      End of options
EOF
}

# update cdup via git clone
update() {
  cd /tmp \
    && echo "... updating" \
    && git clone --depth 1 git://github.com/rigill/cdup.git \
    && cd cdup \
    && make install \
    && cd "${pwd}" \
    && echo "... updated to $(cdup --version)"
}

# parse options
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case $1 in
    -V | --version )
      echo $version
      ;;
    -U | --update )
      update
      ;;
    -h | --help )
      usage
      ;;
  esac
  shift
done
if [[ "$1" == "--" ]]; then shift; fi

# check first parameter is set
if [ -n "$1" ]; then
  dir="${pwd%$1*}${1}"
fi

if [ -z "$*" ]; then
  echo "cdup: try 'cdup --help'" || exit 1
fi

# check if directory exists
if [ -d "${dir}" ]; then
  cd "$dir" || return
fi
