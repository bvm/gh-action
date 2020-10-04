#!/bin/bash
set -e

export BVM_INSTALL_DIR=$HOME/.bvm

# Install if necessary
if [ ! -f $BVM_INSTALL_DIR/bin/bvm-bin ]
then
  curl -fsSL https://bvm.land/install.sh | sh
fi

. $BVM_INSTALL_DIR/bin/bvm-init

# Find all .bvmrc.json files and install
find -L . -name ".bvmrc.json" | while read line ; do
  cd $(dirname $line)
  bvm install
done
