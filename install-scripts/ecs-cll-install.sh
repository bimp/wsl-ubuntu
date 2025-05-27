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

ECS_CLI_VERSION="1.21.0"
DOWNLOAD_DIR="/tmp/ecs-cli"
ECS_CLI_BIN="/usr/local/bin/ecs-cli"

# Dynamically determine architecture
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ECS_ARCH="$("$SCRIPT_DIR/detect_arch.sh")"

# Function to check installed version
is_installed() {
    if command -v ecs-cli >/dev/null 2>&1; then
        local current_version
        current_version="$(ecs-cli --version  2>&1 | awk '{print $3}')"
        if [[ "$current_version" == "$ECS_CLI_VERSION" ]]; then
            return 0
        fi
    fi
    return 1
}

# Exit if the correct version is already installed
if is_installed; then
    echo "ecs-cli $ECS_CLI_VERSION is already installed. Exiting."
    exit 0
fi

# Prepare download directory
mkdir -p "$DOWNLOAD_DIR"

# Setup trap to cleanup download directory on exit
trap 'rm -rf "$DOWNLOAD_DIR"' EXIT

# Download ecs-cli binary for the correct architecture directly to download directory
BINARY_URL="https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-${ECS_ARCH}-v${ECS_CLI_VERSION}"
curl -L -o "$DOWNLOAD_DIR/ecs-cli" "$BINARY_URL"
chmod +x "$DOWNLOAD_DIR/ecs-cli"

# Move binary to install path
sudo mv "$DOWNLOAD_DIR/ecs-cli" "$ECS_CLI_BIN"

echo "ecs-cli $ECS_CLI_VERSION installed successfully."
echo "ecs-cli version: "
ecs-cli --version
