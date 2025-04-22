#!/bin/bash
# =======================================
# setup-popos-dev-studio.sh
# Full Dev + Media Stack for Pop!_OS 22.04 LTS (NVIDIA Edition)
# Architected by Ollie (in collaboration with Scott, Auggie, Claude)
# Attribution: [https://jscottgraham.us](https://jscottgraham.us) | [scott@wordstofilmby.com](mailto:scott@wordstofilmby.com)
# =======================================

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
curl https://pyenv.run | bash

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
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
sudo usermod -aG docker $USER

# -----------------------------------------
# Install NVIDIA Drivers (if not present)
# -----------------------------------------
log "Installing NVIDIA drivers and CUDA toolkit..."
sudo apt install -y nvidia-driver-535 nvidia-cuda-toolkit

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
log "üìè* stant: REBOOT your system manually after this script to complete NT¢“A Adocker group setup."

# -----------------------------------------
# Attribution
# -----------------------------------------
log "Setup script created by ARCHitect Ollie, in collaboration with Scott, Auggie, and Claude."
log "For support, contact: [jscottgraham.us](https://jscottgraham.us) or [scott@wordstofilmby.com](mailto:scott@wordstofilmby.com)"

# -----------------------------------------
# END OF SCRIPT
# -----------------------------------------

exit 0