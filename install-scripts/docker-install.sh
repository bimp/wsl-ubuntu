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

echo -e "\n Installing docker..."

# Function to check if Docker is installed
is_docker_installed() {
    command -v docker >/dev/null 2>&1 && docker --version | grep -q "Docker version"
}

if is_docker_installed; then
    echo "Docker is already installed. No action needed."
    printf "\n docker version:\n"
    docker --version
    exit 0
fi

echo "Docker not found. Proceeding with installation..."

# Add Docker's official GPG key
sudo -u root install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo -u root gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo -u root chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    sudo -u root tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index and install Docker
sudo -u root apt-get update -qq
sudo -u root apt-get install -y -qq \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Add current user to docker group
sudo -u root usermod -aG docker $CURRENT_USER

printf "\n docker version:\n"
docker --version