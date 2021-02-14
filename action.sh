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
  curl -fsSL https://bvm.land/install.sh | sh
fi

# Setup for bvm install
if [ "$is_windows" == "1" ]
then
  PATH="$BVM_INSTALL_DIR/bin:$PATH"
  export PATH
else
  . "$BVM_INSTALL_DIR/bin/bvm-init"
fi

# Mark the powershell script as executable
if [ "$is_windows" == "1" ]
then
  chmod +x $GITHUB_ACTION_PATH/bvm-install.ps1
fi

# Find all .bvmrc.json files and install
find -L . -name ".bvmrc.json" | while read line ; do
  if [ "$is_windows" == "1" ]
  then
    # launch bvm install from powershell because bash can't understand the bvm.cmd file
    $GITHUB_ACTION_PATH/bvm-install.ps1 $(dirname $line)
  else
    (
        cd $(dirname $line)
        bvm install
    )
  fi
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
