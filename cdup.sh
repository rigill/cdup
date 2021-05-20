#!/usr/bin/env bash

version="0.0.2"

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
    && rm -fr /tmp/cdup \
    && echo "... updating" \
    && git clone --depth 1 git://github.com/rigill/cdup.git \
    && cd cdup \
    && echo "$(pwd)" \
    && make install \
    && echo "... updated to $(cdup --version)"
  exit
}

# parse options
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case $1 in
    -V | --version )
      echo $version
      exit
      ;;
    -U | --update )
      update
      ;;
    -h | --help )
      usage
      exit
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
  # echo "$dir"
  cd "$dir" || exit
fi
