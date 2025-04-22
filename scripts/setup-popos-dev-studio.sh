#!/bin/bash
# =========================================
# setup-popos-dev-studio.sh
# Full Dev + Media Stack for Pop!_OS 22.04 LTS (NVIDIA Edition)
# Architected by Ollie (in collaboration with Scott, Auggie, Claude)
# Attribution: [https://jscottgraham.us](https://jscottgraham.us) | [scott@wordstofilmby.com](mailto:scott@wordstofilmby.com)
# =========================================

set -e

# -----------------------------------------
# Helper Functions
# -----------------------------------------
log() {
  echo -e "\n\033[1;34m[INFO]\033[0m $1"
}

error() {
  echo -e "\n\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

# -----------------------------------------
# Initial System Update
# -----------------------------------------
log "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# -----------------------------------------
# Install Base Development Tools
# -----------------------------------------
log "Installing base development tools..."
sudo apt install -y build-essential curl wget git unzip zip tar software-properties-common lsb-release ca-certificates apt-transport-https gnupg

# -----------------------------------------
# Install Media Tools
# -----------------------------------------
log "Installing media production tools..."
sudo apt install -y ffmpeg obs-studio gimp kdenlive audacity inkscape

# -----------------------------------------
# Install Python 3.10 + pip (System Default)
# -----------------------------------------
log "Installing Python 3.10 and pip..."
sudo apt install -y python3 python3-pip python3-venv

# -----------------------------------------
# Install pyenv (optional, for Python 3.12+ later)
# -----------------------------------------
log "Installing pyenv (optional Python version manager)..."
curl -fsSL https://pyenv.run | bash

# Setup pyenv in shell configs
if ! grep -q 'pyenv init' ~/.bashrc; then
  echo -e '\n# Pyenv Setup' >> ~/.bashrc
  echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
  echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
fi

# -----------------------------------------
# Install Docker
# -----------------------------------------
log "Installing Docker (latest stable)..."
# Uninstall old Docker if any
sudo apt remove -y docker docker-engine docker.io containerd runc || true

# Set up official Docker repo
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user to Docker group
sudo usermod -aG docker $USER

# -----------------------------------------
# Install NVIDIA Drivers (if not present)
# -----------------------------------------
log "Checking for NVIDIA drivers..."
if ! command -v nvidia-smi &> /dev/null; then
  log "NVIDIA driver not detected, installing..."
  sudo apt install -y nvidia-driver-535 nvidia-cuda-toolkit
else
  log "NVIDIA driver detected, skipping install."
fi

# -----------------------------------------
# Install VS Code
# -----------------------------------------
log "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# -----------------------------------------
# Install DevOps / Infra Tools
# -----------------------------------------
log "Installing optional DevOps/Infra tools..."
sudo apt install -y jq htop tmux tree

# -----------------------------------------
# Final System Cleanup
# -----------------------------------------
log "Cleaning up unnecessary packages..."
sudo apt autoremove -y

# -----------------------------------------
# Finishing Steps
# -----------------------------------------
log "All core packages installed."
log "🔵 Important: REBOOT your system manually after this script to complete NVIDIA and Docker group setup."

# -----------------------------------------
# Attribution
# -----------------------------------------
log "Setup script created by ARCHitect Ollie, in collaboration with Scott, Auggie, and Claude."
log "For support, contact: [jscottgraham.us](https://jscottgraham.us) or [scott@wordstofilmby.com](mailto:scott@wordstofilmby.com)"

# -----------------------------------------
# END OF SCRIPT
# -----------------------------------------

exit 0
