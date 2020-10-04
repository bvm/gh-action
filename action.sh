#!/bin/bash
set -e

export BVM_INSTALL_DIR=$HOME/.bvm

# Check if windows
case $(uname -s) in
*_NT-*) is_windows=1 ;;
*) is_windows=0 ;;
esac

# Install if necessary
if [ ! -f $BVM_INSTALL_DIR/bin/bvm-bin ]
then
  . test_install.sh
  #curl -fsSL https://bvm.land/install.sh | sh
fi

# Find all .bvmrc.json files and install
find -L . -name ".bvmrc.json" | while read line ; do
  cd $(dirname $line)
  bvm install
done

if [ "$is_windows" == "1" ]
then
  echo "$APPDATA\\bvm\\shims" >> $GITHUB_PATH
  echo "$USERPROFILE\\.bvm\\bin" >> $GITHUB_PATH
else
  echo "BVM_INSTALL_DIR=$BVM_INSTALL_DIR" >> $GITHUB_ENV
  echo "$HOME/.bvm/shims" >> $GITHUB_PATH
  echo ". \$HOME/.bvm/bin/bvm-init" >> "$HOME/.bash_profile"
fi
