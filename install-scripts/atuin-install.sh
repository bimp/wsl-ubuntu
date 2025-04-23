#!/usr/bin/env bash

set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

# Get the current user (works reliably even under sudo)
# use Bash's parameter expansion to provide a default value when the variable is unset
if [ -n "${SUDO_USER-}" ]; then
    CURRENT_USER="$SUDO_USER"
else
    CURRENT_USER="$(whoami)"
fi

# install atuin - sync, search, backup shell history
# https://atuin.sh
# This script installs atuin using the official installation script.
echo -e "\nInstalling atuin..."
# install only if ~/.atuin/bin/atuin does not exist
if [ -f ~/.atuin/bin/atuin ]; then
    echo "atuin already installed. skipping installation."
else
    sudo -u $CURRENT_USER curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

printf "\natuin version:\n"
~/.atuin/bin/atuin --version
