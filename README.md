# Pop!_OS Dev Studio Setup

**One-click install script for a full-stack Development + Media Production environment**  
Built for **Pop!_OS 22.04 LTS (NVIDIA Edition)**

---

## 📦 What This Script Installs

- Full **System Updates**
- Core **Development Tools** (`build-essential`, `git`, `curl`, `unzip`, `software-properties-common`, etc.)
- **Python 3.10** (system default) + `pip`
- **Optional Pyenv Installation** (for managing Python 3.12+)
- **Docker + docker-compose**
- **NVIDIA Drivers (535)** and **CUDA Toolkit**
- **Media Tools**: `ffmpeg`, `obs-studio`, `gimp`, `kdenlive`, `audacity`, `inkscape`
- **VS Code** (official Microsoft package)
- **DevOps Utilities**: `jq`, `htop`, `tmux`, `tree`
- **System Cleanup** (autoremove unnecessary packages)

---

## 💀 How to Use

```
# Download the script
wget https://raw.githubusercontent.com/cheddarfox/popos-dev-studio-setup/main/setup-popos-dev-studio.sh

# Make it executable
chmod +x setup-popos-dev-studio.sh

# Run it
./setup-popos-dev-studio.sh
```

✓ **Important**: After the script finishes, **REBOOT manually** to finalize NVIDIA drivers and Docker group settings.

---

## 🛧 Requirements

- **Pop!_OS 22.04 LTS (NVIDIA Edition)**
- Minimum **100GB free disk space**
- Minimum **16GB RAM** (32GB+ strongly recommended for media/AI work)
- Admin (sudo) privileges

---

## ❗? FAQs

**Q: Does this script encrypt my drive?**  
A: No — full disk encryption must be enabled manually during Pop!_OS installation.

**Q: Will this install Python 3.12?**  
A: By default it installs Python 3.10 system-wide.  
Use **Pyenv** (installed by the script) to easily install and manage Python 3.12+ versions if needed.

**Q: Can I run this script on Ubuntu or another distrm?**  
A: It's designed specifically for **Pop!_OS 22.04 LTS**. Minor adjustments may allow it to work elsewhere, but not guaranteed.

**Q: Do I need to reboot after running the script?**  
A: **YES!** Reboot is required for Docker group and NVIDIA driver changes to fully take effect.

---

## ✏️ Attribution

Script created by **ARCHitect Ollie**,  
in collaboration with **Scott**, **Auggie**, and **Claude**.

> **For support:**  
> [jscottgraham.us](https://jscottgraham.us)  
> [scott@wordstofilmby.com](mailto:scott@wordstofilmby.com)

---

## 🔢 Final Notes

- Built with ❤️ for developers, creators, and AI innovators.
- Contributions welcome after first release.
- **MIT License** (open source, modification allowed, attribution required).

---