#!/bin/bash
set -e

# ── Source shared library ─────────────────────────────────────────────────────
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/lib.sh"

log_section "AUR Helpers (yay & paru)"

# 1. Install prerequisites
log_info "Ensuring base-devel and git are installed..."
sudo pacman -S --needed --noconfirm git base-devel

# 2. Install yay
if command_exists yay; then
    log_success "yay is already installed. Skipping."
else
    log_info "Installing yay..."
    TEMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TEMP_DIR"' EXIT
    git clone https://aur.archlinux.org/yay.git "$TEMP_DIR/yay"
    (cd "$TEMP_DIR/yay" && makepkg -si --noconfirm)
    log_success "yay installed successfully."
fi

# 3. Install paru
if command_exists paru; then
    log_success "paru is already installed. Skipping."
else
    log_info "Installing paru..."
    TEMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TEMP_DIR"' EXIT
    git clone https://aur.archlinux.org/paru.git "$TEMP_DIR/paru"
    (cd "$TEMP_DIR/paru" && makepkg -si --noconfirm)
    log_success "paru installed successfully."
fi

log_success "AUR helpers ready."
