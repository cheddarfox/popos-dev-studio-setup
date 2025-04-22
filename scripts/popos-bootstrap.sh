#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Pop!_OS Bootstrap Script
# Automates post-install setup for a dev workstation on Pop!_OS 22.04 LTS
# Tested on ASUS FX503VD (i7-7700HQ, 32GB RAM, GTX 1050)
# -----------------------------------------------------------------------------
set -euo pipefail
IFS='*\n[t'
# 1. Update & Upgrade
sudo apt update && sudo apt full-upgrade -y
# 2. Install Essential Packages
sudo apt install -y \
  build-essential git curl wget software-properties-common apt-transport-https ca-certificates gnupg lsb-release \
  htop glances fzf ripgrep bat exa \
  zsh \
  python3-pip python3-venv \
  tmux tree \
  docker.io \
  flatpak snapd \
  tlp cpufrequtils \
  timeshift \
  ufw fail2ban
# 3. Enable & Start System Services
sudo systemctl enable --now tlp
sudo systemctl enable --now fstrim.timer
sudo ufw enable
# 4. VS Code Repository & Installation
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code
rm microsoft.gpg
# 5. NVIDIA Driver & Prime Setup
sudo apt install -y nvidia-driver-535 nvidia-prime
# Switch to NVIDIA Performance mode by default
sudo prime-select nvidia
# 6. Docker GPU Runtime (nvidia-docker2)
distribution=$( . /etc/os-release && echo $ID$VERSION_ID )
curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -fsSL https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update
sudo apt install -y nvidia-docker2
sudo systemctl restart docker
# 7. Flatpak Setup
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# 8. Snap: Electron Wrappers
sudo snap install chatgpt-desktop --classic
# For Claude wrapper, replace <snap-name> with your chosen package
# sudo snap install <claude-snap-name>
# 9. Install oh-my-zsh (proper method via script)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 10. Install media codecs
sudo apt install -y ubuntu-restricted-extras ffmpeg
# 11. Optional: Clone & Install Your Dotfiles
# git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
# bash ~/dotfiles/install.sh
# 12. Cleanup
sudo apt autoremove -y && sudo apt autoclean -y
echo -e "\nPop!_OS bootstrap complete! Reboot to apply firmware updates and driver changes.\n"