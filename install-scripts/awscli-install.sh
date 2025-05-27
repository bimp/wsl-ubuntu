#!/usr/bin/env bash

# set -o errexit # exits if error occurs
set -o nounset # fails when accessing an unset variable
set -o pipefail # pipeline command is treated as failed, even if one command in the pipeline fail

echo -e "\n Installing awscli..."

# Specify the AWS CLI version
# releases can be found at https://github.com/aws/aws-cli/tags
AWSCLI_VERSION="2.27.22"

echo -e "\nTarget AWS CLI version: $AWSCLI_VERSION"

# Check if aws is installed and version matches
if command -v aws >/dev/null 2>&1; then
    INSTALLED_VERSION=$(aws --version 2>&1 | awk '{print $1}' | cut -d/ -f2)
    if [[ "$INSTALLED_VERSION" == "$AWSCLI_VERSION" ]]; then
        echo "AWS CLI version $AWSCLI_VERSION is already installed. Exiting."
        # If sourced, use return; if executed, use exit
        (return 0 2>/dev/null) && return 0 || exit 0
    else
        echo "Different AWS CLI version detected: $INSTALLED_VERSION. Proceeding with installation."
    fi
else
    echo "AWS CLI is not installed. Proceeding with installation."
fi

echo -e "\nInstalling AWS CLI version $AWSCLI_VERSION..."

TMPDIR="/tmp/awscli"
ZIPFILE="$TMPDIR/awscliv2.zip"

mkdir -p "$TMPDIR"

# Download directly to the specified location
curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" -o "$ZIPFILE"

unzip -q "$ZIPFILE" -d "$TMPDIR"

sudo -u root "$TMPDIR/aws/install" --update

printf "\nAWS CLI version after installation:\n"
aws --version

rm -rf "$TMPDIR"

printf "\n awscli version:\n"
aws --version

