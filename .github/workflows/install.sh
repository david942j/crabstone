#!/bin/bash

set -e -x

install_from_src()
{
  package=$1
  url=$2
  echo "Installing $package"
  wget "$url" -O pkg.tar.gz
  tar xvf pkg.tar.gz
  rm pkg.tar.gz
  mv $package* "$package"
  cd $package && make && cd -
}

setup_linux()
{
  # install capstone
  # There's libcapstone3 available on apt, but we want to test against a newer version.
  sudo apt install make
  install_from_src capstone 'https://github.com/aquynh/capstone/archive/4.0.2.tar.gz'
}

setup_osx()
{
  # install capstone
  brew install capstone
}

if [[ "$1" == "macOS" ]]; then
  setup_osx
elif [[ "$1" == "Linux" ]]; then
  setup_linux
fi

set +e +x
