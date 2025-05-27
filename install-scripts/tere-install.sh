#!/usr/bin/env bash

# set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

# install the tere command line tool binary
# https://github.com/mgunyho/tere
# MUST be run with command:
# sudo -u USERNAME ./tere-install.sh

echo -e "\nInstalling tere..."
# Specify the tere version
# releases can be found at https://github.com/mgunyho/tere/releases
TEREVERSION="1.6.0"

# Check if tere is already installed and matches the desired version
if command -v /usr/local/bin/tere >/dev/null 2>&1; then
    INSTALLED_VERSION=$(/usr/local/bin/tere -V 2>&1 | awk '{print $2}')
    if [[ "$INSTALLED_VERSION" == "$TEREVERSION" ]]; then
        echo "tere version $TEREVERSION is already installed. Exiting."
        # If sourced, use return; if executed, use exit
        (return 0 2>/dev/null) && return 0 || exit 0
    fi
fi

mkdir -p /tmp/tere
cd /tmp/tere
if [ ! -f /tmp/tere/tere-${TEREVERSION}-x86_64-unknown-linux-gnu.zip ]; then
    wget https://github.com/mgunyho/tere/releases/download/v${TEREVERSION}/tere-${TEREVERSION}-x86_64-unknown-linux-gnu.zip
fi
sudo -u root unzip -o tere-${TEREVERSION}-x86_64-unknown-linux-gnu.zip
sudo -u root chmod +x tere
sudo -u root cp tere /usr/local/bin

printf "\ntere version:\n"
/usr/local/bin/tere -V

# don't forget to add the following to your .bashrc file
# tere() {
#     local result=$(command tere "$@")
#     [ -n "$result" ] && cd -- "$result"
# }

cd ~
rm -rf /tmp/tere
