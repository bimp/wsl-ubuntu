#!/bin/bash

# exit on any error
set -e
# exit on any pipeline errors
set -o pipefail

# initialize install-scripts directory
INSTALL_SCRIPTS_DIR="$HOME/install-scripts"

# Verify install directory exists
if [[ ! -d "$INSTALL_SCRIPTS_DIR" ]]; then
    echo "Error: Install directory $INSTALL_SCRIPTS_DIR not found" >&2
    exit 1
fi

# this file to be run to initialize home directory first time
# or as needed on demand
# MUST be run with command:
# sudo -u USERNAME ./bootstrap.sh

# apt stuff
sudo -u root apt -y update
sudo -u root apt install -y unzip tree jq openssl uuid ntpsec keychain
sudo -u root apt install -y build-essential shellcheck cmdtest
sudo -u root apt install -y apt-transport-https ca-certificates gnupg lsb-release

# ssh and keychain stuff
sudo -u bimp chmod 600 $HOME/.ssh/*

# install hishtory - a better shell history
# https://github.com/ddworken/hishtory

# install 'bat' which is 'cat' replacement
# https://github.com/sharkdp/bat
source "$INSTALL_SCRIPTS_DIR/bat-install.sh"

# install tere directory navigation tool
# https://github.com/mgunyho/tere


# python stuff
# install pip, uv
