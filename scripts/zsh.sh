#!/bin/bash
set -e

# ── Source shared library ─────────────────────────────────────────────────────
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/lib.sh"

log_section "Zsh & Oh My Zsh Setup"

# 1. Install Zsh
log_info "Installing zsh, curl, git..."
sudo pacman -S --needed --noconfirm zsh curl git

# 2. Install Oh My Zsh (unattended, preserves existing .zshrc)
if [ -d "$HOME/.oh-my-zsh" ]; then
    log_success "Oh My Zsh is already installed. Skipping."
else
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    log_success "Oh My Zsh installed."
fi

# 3. Install Powerlevel10k & plugins into OMZ custom folder
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

log_info "Installing plugins and themes..."

if [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    log_success "Powerlevel10k already installed. Skipping."
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    log_success "Powerlevel10k installed."
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    log_success "zsh-autosuggestions already installed. Skipping."
else
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    log_success "zsh-autosuggestions installed."
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    log_success "zsh-syntax-highlighting already installed. Skipping."
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    log_success "zsh-syntax-highlighting installed."
fi

# 4. Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    log_info "Changing default shell to zsh..."
    sudo chsh -s "$(which zsh)" "$USER"
    log_success "Default shell set to zsh."
else
    log_success "Zsh is already the default shell."
fi

# NOTE: .zshrc is managed via symlink from home/.zshrc — handled by master-installation.sh

log_success "Zsh setup complete. Restart your terminal to apply."
