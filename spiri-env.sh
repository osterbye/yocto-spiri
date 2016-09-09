#!/bin/sh
############################################################################
##
## Copyright (C) 2016 Spiri ApS
##
############################################################################

while test -n "$1"; do
  case "$1" in
    "--help" | "-h")
      echo "Usage: . $0 [build directory]"
      return 0
      ;;
    *)
      QT_INSTALL_DIR=$1
    ;;
  esac
  shift
done

THIS_SCRIPT="spiri-env.sh"
if [ "$(basename -- $0)" = "${THIS_SCRIPT}" ]; then
    echo "Error: This script needs to be sourced. Please run as '. $0'"
    return 1
fi

unset QT_INSTALL_DIR

export MACHINE=apalis-imx6
source ./setup-environment.sh

echo "You can build the Spiri Linux image by typing 'bitbake spiri-image' and"
echo "the Spiri SDK by typing 'bitbake spiri-sdk'"
echo ""

export PS1="\[\e[32;1m\][yocto-spiri]\[\e[0m\]:\w> "
