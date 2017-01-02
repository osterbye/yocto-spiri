#!/bin/sh
############################################################################
##
## Copyright (C) 2016-2017 Spiri ApS
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

THIS_SCRIPT="create-spiri-env.sh"
if [ "$(basename -- $0)" = "${THIS_SCRIPT}" ]; then
    echo "Error: This script needs to be sourced. Please run as '. $0'"
    return 1
fi

QT_INSTALL_DIR=${QT_INSTALL_DIR:-$HOME/Qt/}

if [ -f ${QT_INSTALL_DIR}/5.8/Boot2Qt/sources/meta-b2qt/b2qt-init-build-env ]; then
    ${QT_INSTALL_DIR}/5.8/Boot2Qt/sources/meta-b2qt/b2qt-init-build-env init --device apalis-imx6
else
    echo "Error: Cannot find Boot2Qt installation directory ${QT_INSTALL_DIR}"
    return 1
fi

unset QT_INSTALL_DIR

export MACHINE=apalis-imx6
source ./setup-environment.sh

cd ../sources
git clone -b anvil git@bitbucket.org:spiri_io/meta-spiri.git
cd meta-spiri
source ./setup.sh ../../build-apalis-imx6

git clone -b anvil git@bitbucket.org:spiri_io/apalis-flash.git

export PS1="\[\e[32;1m\][yocto-spiri]\[\e[0m\]:\w> "
