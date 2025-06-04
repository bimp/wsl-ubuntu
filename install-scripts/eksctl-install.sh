#!/usr/bin/env bash

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

EKSCTL_VERSION="0.208.0"

EKSCTL_BIN="/usr/local/bin/eksctl"

# Dynamically determine architecture
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARCH="$("$SCRIPT_DIR/detect_arch.sh")"

# Create and clean up temp directory
TMP_DIR="/tmp/eksctl"
mkdir -p "$TMP_DIR"
trap 'sudo -u root rm -rf "$TMP_DIR"' EXIT

# Check if eksctl is already installed and at the desired version
if command -v eksctl >/dev/null 2>&1; then
    INSTALLED_VERSION=$(eksctl version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
    if [ "$INSTALLED_VERSION" = "$EKSCTL_VERSION" ]; then
        echo "eksctl version $EKSCTL_VERSION is already installed. Exiting."
        exit 0
    fi
fi

# Download and install eksctl
OS=$(uname -s)
DOWNLOAD_URL="https://github.com/eksctl-io/eksctl/releases/download/v${EKSCTL_VERSION}/eksctl_${OS}_${ARCH}.tar.gz"

echo "Downloading eksctl version $EKSCTL_VERSION from $DOWNLOAD_URL"
curl --silent --location "$DOWNLOAD_URL" --output "$TMP_DIR/eksctl.tar.gz"

tar xzf "$TMP_DIR/eksctl.tar.gz" -C "$TMP_DIR"

sudo -u root mv "$TMP_DIR/eksctl" "$EKSCTL_BIN"
sudo -u root chmod +x "$EKSCTL_BIN"

printf "\n eksctl version:\n"
eksctl version