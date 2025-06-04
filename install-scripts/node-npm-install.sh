#!/usr/bin/env bash

set -o nounset
set -o pipefail

# Get the current user (works reliably even under sudo)
if [ -n "${SUDO_USER-}" ]; then
    CURRENT_USER="$SUDO_USER"
else
    CURRENT_USER="$(whoami)"
fi

NODE_VERSION="22.x"
TMP_DIR="/tmp/nodejs-install"

mkdir -p "$TMP_DIR"
trap 'sudo rm -rf "$TMP_DIR"' EXIT

# Check if Node.js 22 is already installed
if command -v node >/dev/null 2>&1; then
    INSTALLED_VERSION=$(node -v | grep -oE '^[vV]22')
    if [ -n "$INSTALLED_VERSION" ]; then
        echo "Node.js version 22 is already installed. Exiting."
        exit 0
    fi
fi

# Download and run NodeSource setup script for Node.js 22
curl -fsSL "https://deb.nodesource.com/setup_22.x" -o "$TMP_DIR/nodesource_setup.sh"
sudo -E bash "$TMP_DIR/nodesource_setup.sh"

# Install Node.js (includes npm)
echo "Installing Node.js 22 and npm..."
sudo apt install -y nodejs

# Verify installation
echo -e "\nNode.js version:"
node -v
echo -e "\nnpm version:"
npm -v

echo "Node.js 22 and npm installation complete."
