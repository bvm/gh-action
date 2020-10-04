#!/bin/bash
set -e

# Install if necessary
if [ ! -f $HOME/.bvm/bin/bvm-bin ]
then
  curl -fsSL https://bvm.land/install.sh | sh
fi

export BVM_INSTALL_DIR=$HOME/.bvm
. $BVM_INSTALL_DIR/bin/bvm-init

# Find all .bvmrc.json files and install
find -L . -name ".bvmrc.json" | while read line ; do
  cd $(dirname $line)
  bvm install
done
