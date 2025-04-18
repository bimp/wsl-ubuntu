#!/usr/bin/env bash

set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

# install the tere command line tool binary
# https://github.com/mgunyho/tere
# MUST be run with command:
# sudo -u USERNAME ./tere-install.sh

echo -e "\nInstalling tere..."
# install tere
TEREVERSION="1.6.0"
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
