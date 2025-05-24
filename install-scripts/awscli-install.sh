#!/usr/bin/env bash

# set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

echo -e "\n Installing awscli..."
# install awscli
mkdir -p /tmp/awscli
cd /tmp/awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo -u root ./aws/install

printf "\n awscli version:\n"
aws --version

cd ~
rm -rf /tmp/awscli
