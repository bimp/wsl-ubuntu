#!/usr/bin/env bash

set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

echo "Installing bat..."
sudo -u root apt install -y bat

# the executable may be installed as batcat instead of bat (due to a name clash with another package). 
# You can set up a bat -> batcat symlink or alias to prevent any issues that may come up because of 
# this and to be consistent with other distributions
mkdir -p $HOME/.local/bin
ln -sf /usr/bin/batcat $HOME/.local/bin/bat

echo "Symbolic link created: ~/.local/bin/bat -> /usr/bin/batcat"

printf "\nbat version:\n"
/usr/bin/batcat --version
