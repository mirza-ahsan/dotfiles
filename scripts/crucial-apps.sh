#!/bin/bash
set -e

# ── Source shared library ─────────────────────────────────────────────────────
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/lib.sh"

log_section "Crucial Applications"

# Define all packages in a single array for clean management.
# Add or remove packages here as needed.
PACKAGES=(
    zen-browser-bin
    ghostty
    visual-studio-code-bin
    yazi
    cmake
)

log_info "Installing ${#PACKAGES[@]} packages: ${PACKAGES[*]}"
paru -S --noconfirm --needed "${PACKAGES[@]}"

log_success "All crucial applications installed."
