#!/bin/bash
set -e

# ── Source shared library ─────────────────────────────────────────────────────
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/lib.sh"

log_section "Tmux & Plugin Manager"

# 1. Install tmux (from official repos, no AUR helper needed)
log_info "Installing tmux..."
sudo pacman -S --needed --noconfirm tmux

# 2. Install TPM (Tmux Plugin Manager)
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    log_success "TPM is already installed. Skipping."
else
    log_info "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    log_success "TPM installed."
fi

# NOTE: .tmux.conf is managed via symlink from home/.tmux.conf — handled by master-installation.sh

log_success "Tmux setup complete."
log_info "After starting tmux, press ${BOLD}Prefix (Ctrl+S) + I${RESET} to install plugins."
