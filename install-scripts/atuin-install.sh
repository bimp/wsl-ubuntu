#!/usr/bin/env bash

set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

# install atuin - sync, search, backup shell history
# https://atuin.sh
# This script installs atuin using the official installation script.
echo "Installing atuin..."
sudo -u bimp curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
