#!/usr/bin/env bash

# set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

# install python uv package and project manager
# https://docs.astral.sh/uv/getting-started/installation/

# MUST be run with command:
# sudo -u USERNAME ./uv-install.sh

echo -e "\nInstalling uv..."
# install uv
mkdir -p /tmp/uv
cd /tmp/uv
curl -LsSf https://astral.sh/uv/install.sh | sh

printf "\n uv version:\n"
uv --version

cd ~
rm -rf /tmp/uv
