# Scripts Directory

This directory contains all the scripts for the Pop!_OS Developer Handbook.

## Available Scripts

| Script | Purpose |
|-------|--------|
| [setup-popos-dev-studio.sh](setup-popos-dev-studio.sh) | Comprehensive development and media environment setup |
| [popos-bootstrap.sh](popos-bootstrap.sh) | Basic development environment setup |
| [hardware-info.ps1](hardware-info.ps1) | PowerShell script to gather Windows hardware details before migration |
| [optimize-nvidia.sh](optimize-nvidia.sh) | NVIDIA GPU optimization for development and media work |
| [media-codecs.sh](media-codecs.sh) | Comprehensive multimedia support installation |

## Usage

### Option 1: Full Dev Studio Setup (Comprehensive)

Our flagship script that installs a complete development and media production environment:

```bash
# Download the script
wget https://raw.githubusercontent.com/cheddarfox/popos-dev-studio-setup/main/scripts/setup-popos-dev-studio.sh

# Make it executable
chmod +x setup-popos-dev-studio.sh

# Run it
./setup-popos-dev-studio.sh
```

### Option 2: Basic Bootstrap (Lightweight)

A more minimal setup focusing on essential development tools:

```bash
# Download the script
wget https://raw.githubusercontent.com/cheddarfox/popos-dev-studio-setup/main/scripts/popos-bootstrap.sh

# Make it executable
chmod +x popos-bootstrap.sh

# Run it
./popos-bootstrap.sh
```

## Contributing

If you find any issues or have suggestions for improvements, please feel free to contribute by submitting a pull request or opening an issue. See the [CONTRIBUTING.md](/.github/CONTRIBUTING.md) file for more details.