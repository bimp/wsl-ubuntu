#!/usr/bin/env bash

# set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

# Specify the atuin version
# releases can be found at https://github.com/atuinsh/atuin/releases
ATUIN_VERSION="18.6.1" 
INSTALLER_URL="https://github.com/atuinsh/atuin/releases/download/v${ATUIN_VERSION}/atuin-installer.sh"
INSTALLER_PATH="/tmp/atuin"

# Get the current user (works reliably even under sudo)
# use Bash's parameter expansion to provide a default value when the variable is unset
if [ -n "${SUDO_USER-}" ]; then
    CURRENT_USER="$SUDO_USER"
else
    CURRENT_USER="$(whoami)"
fi

# Function to get installed Atuin version
get_installed_version() {
    if [ -f ~/.atuin/bin/atuin ]; then
        ~/.atuin/bin/atuin --version | awk '{print $2}'
    else
        echo ""
    fi
}

INSTALLED_VERSION=$(get_installed_version)

if [ "$INSTALLED_VERSION" = "$ATUIN_VERSION" ]; then
    echo "Atuin version $ATUIN_VERSION is already installed. Exiting."
    # If sourced, use return; if executed, use exit
    (return 0 2>/dev/null) && return 0 || exit 0
fi

echo -e "\nInstalling Atuin version $ATUIN_VERSION..."

# Download the installer to /tmp/atuin
sudo -u $CURRENT_USER curl --proto '=https' --tlsv1.2 -LsSf -o "$INSTALLER_PATH" "$INSTALLER_URL"

# Ensure the installer is deleted on script exit (success or failure)
trap 'rm -f "$INSTALLER_PATH"' EXIT

echo -e "\nInstalling Atuin version $ATUIN_VERSION..."

# Run the installer
sudo -u $CURRENT_USER bash "$INSTALLER_PATH"

# install bash-preexec.sh to allow atuin to work with bash
# https://docs.atuin.sh/guide/installation/#bash
sudo -u $CURRENT_USER curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh

printf "\natuin version:\n"
~/.atuin/bin/atuin --version
