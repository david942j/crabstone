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
  install_from_src capstone 'https://github.com/aquynh/capstone/archive/4.0.2.tar.gz'

  export LD_LIBRARY_PATH=$GITHUB_WORKSPACE/capstone/:$LD_LIBRARY_PATH
}

setup_osx()
{
  # install capstone
  brew install capstone
  export DYLD_LIBRARY_PATH=/usr/local/opt/capstone/lib:$DYLD_LIBRARY_PATH
}

if [[ "$CI_OS_NAME" == "macOS" ]]; then
  setup_osx
elif [[ "$CI_OS_NAME" == "Linux" ]]; then
  setup_linux
fi
set +e +x
