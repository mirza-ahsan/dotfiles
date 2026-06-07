#!/bin/bash
set -e

# ── Source shared library ─────────────────────────────────────────────────────
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/lib.sh"

log_section "Neovim & Dependencies"

# 1. Install Neovim and required system dependencies
# These are needed for Treesitter compilation, LSP, Telescope grep, etc.
NVIM_DEPS=(
    neovim
    tree-sitter-cli
    gcc
    curl
    tar
    ripgrep
    fd
)

log_info "Installing Neovim and core dependencies..."
sudo pacman -S --needed --noconfirm "${NVIM_DEPS[@]}"
log_success "Neovim and dependencies installed."

# 2. Optional: clang for C/C++ formatting (clang-format) and LSP (clangd)
log_info "Installing clang (provides clangd + clang-format)..."
sudo pacman -S --needed --noconfirm clang
log_success "clang installed."

# 3. Clean old plugin data if this is a fresh setup (no lazy dir = first time)
LAZY_DIR="$HOME/.local/share/nvim/lazy"
if [ ! -d "$LAZY_DIR" ]; then
    log_info "No existing plugin data found. Neovim will bootstrap on first launch."
else
    log_success "Existing plugin data found at ${BOLD}$LAZY_DIR${RESET}. Keeping as-is."
fi

# NOTE: nvim config is symlinked from config/nvim/ → ~/.config/nvim/ by master-installation.sh

log_success "Neovim setup complete."
log_info "Launch ${BOLD}nvim${RESET} to trigger automatic plugin installation (takes 1–3 min on first run)."
