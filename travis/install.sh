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
  install_from_src capstone 'https://github.com/aquynh/capstone/archive/4.0.1.tar.gz'

  export LD_LIBRARY_PATH=$TRAVIS_BUILD_DIR/capstone/:$LD_LIBRARY_PATH
}

setup_osx()
{
  # install capstone
  brew install capstone
  export DYLD_LIBRARY_PATH=/usr/local/opt/capstone/lib:$DYLD_LIBRARY_PATH
}

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  setup_osx
elif [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  setup_linux
fi
set +e +x
