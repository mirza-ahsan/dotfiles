# Dotfiles & System Setup

This repository contains my personal configurations (Hyprland, Neovim, Tmux, Zsh, etc.) and automation scripts to set up a fresh Arch Linux environment from scratch.

## Quick Start

To get everything installed—including AUR helpers, essential apps, SSH keys, and all configurations—run the following commands:

```bash
# 1. Clone the repository to your home folder
git clone https://github.com/mirza-ahsan/dotfiles.git

# 2. Enter the directory
cd ~/dotfiles

# 3. Make the master script executable
chmod +x master-installation.sh

# 4. Run the installation
./master-installation.sh
```

### Symlink-Only Mode

Already have everything installed and just want to deploy the configs?

```bash
./master-installation.sh --link-only
```

This skips all package installations and only creates symlinks from the repo to the correct locations.

---

## What the Master Script Does

The `master-installation.sh` handles the heavy lifting in two phases:

### Phase 1: Package Installation *(skipped with `--link-only`)*

1.  **AUR Helpers:** Installs `yay` and `paru` with proper temp-directory builds.
2.  **Apps:** Installs core software (Zen Browser, Ghostty, VS Code, Yazi, cmake).
3.  **Neovim:** Installs Neovim 0.12+, tree-sitter-cli, ripgrep, fd, clang, and all required system deps.
4.  **Shell & Tools:** Sets up Zsh, Oh My Zsh, Powerlevel10k, plugins, and changes the default shell.
5.  **Tmux:** Installs tmux and the Tmux Plugin Manager (TPM).
6.  **Security:** Interactively generates a new SSH key for GitHub (skipped if one already exists).

### Phase 2: Symlink Deployment

6.  **Config:** Everything in `config/` is mirrored file-by-file into `~/.config/` via symlinks.
7.  **Home:** Everything in `home/` is symlinked directly into `~/` (e.g., `.zshrc`, `.tmux.conf`).

> **Backups:** If any existing real files are found at the target locations, they are automatically backed up to `~/.dotfiles-backup/<timestamp>/` before being replaced with symlinks.

---

## Repository Structure

```
dotfiles/
├── config/             # → symlinked to ~/.config/
│   └── nvim/           #   Full Neovim config (init.lua, plugins, keymaps)
├── home/               # → symlinked to ~/
│   ├── .clang-format   #   C++ formatting rules
│   ├── .tmux.conf      #   Tmux configuration
│   └── .zshrc          #   Zsh configuration (P10k, plugins, keybinds)
├── scripts/            # Modular installation scripts
│   ├── lib.sh          #   Shared utilities (logging, symlinks, backups)
│   ├── aur.sh          #   AUR helper installation (yay, paru)
│   ├── crucial-apps.sh #   Core application installation
│   ├── nvim.sh         #   Neovim + system dependencies
│   ├── zsh.sh          #   Zsh + Oh My Zsh + plugins setup
│   ├── tmux.sh         #   Tmux + TPM setup
│   └── github.sh       #   GitHub SSH key generation
├── master-installation.sh
└── readme.md
```

---

## Adding New Configs

- **~/.config/ files:** Place them under `config/` mirroring the path (e.g., `config/hypr/hyprland.conf` → `~/.config/hypr/hyprland.conf`).
- **Home dotfiles:** Place them under `home/` (e.g., `home/.gitconfig` → `~/.gitconfig`).

Run the master script again (or with `--link-only`) to deploy.

---
