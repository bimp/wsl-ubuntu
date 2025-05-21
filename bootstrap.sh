#!/bin/bash


# set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

# Get the current user (works reliably even under sudo)
# use Bash's parameter expansion to provide a default value when the variable is unset
if [ -n "${SUDO_USER-}" ]; then
    CURRENT_USER="$SUDO_USER"
else
    CURRENT_USER="$(whoami)"
fi

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
sudo -u $CURRENT_USER chmod 600 $HOME/.ssh/*

# set up /etc/default/locale file
# see https://www.tecmint.com/set-system-locales-in-linux/
sudo -u root cp ~/locale /etc/default/locale
echo -e "\nSetting system wide locale at /etc/default/locale..."
sudo -u root cat /etc/default/locale

# install hishtory - a better shell history
# https://github.com/ddworken/hishtory

# install atuin - sync, search, backup shell history
# https://atuin.sh
source "$INSTALL_SCRIPTS_DIR/atuin-install.sh"

# install 'bat' which is 'cat' replacement
# https://github.com/sharkdp/bat
source "$INSTALL_SCRIPTS_DIR/bat-install.sh"

# install tere directory navigation tool
# https://github.com/mgunyho/tere
source "$INSTALL_SCRIPTS_DIR/tere-install.sh"

# python stuff
# install pip, uv
sudo -u root apt install -y python3-pip

# verify version installations
printf "\n python3 version:\n"
/usr/bin/python3 --version
printf "\n pip3 version:\n"
pip3 --version

# install python uv package and project manager
# https://docs.astral.sh/uv/
source "$INSTALL_SCRIPTS_DIR/uv-install.sh"

# install, configure aws stuff

# install, configure docker stuff

# install kubernetes, eks stuff


