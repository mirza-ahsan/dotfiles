#!/bin/bash
# lib.sh — Shared utility functions for dotfiles installation scripts.
# Source this file at the top of every script:
#   SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#   source "$SCRIPTS_DIR/lib.sh"

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Logging ───────────────────────────────────────────────────────────────────
log_info()    { echo -e "${BLUE}[INFO]${RESET}    $*"; }
log_success() { echo -e "${GREEN}[OK]${RESET}      $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${RESET}    $*"; }
log_error()   { echo -e "${RED}[ERROR]${RESET}   $*"; }
log_section() { echo -e "\n${BOLD}${CYAN}━━━ $* ━━━${RESET}\n"; }

# ── Helpers ───────────────────────────────────────────────────────────────────

# Check if a command exists on the system.
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Back up an existing file or directory to ~/.dotfiles-backup/<timestamp>/
# Usage: backup_if_exists /path/to/file
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
backup_if_exists() {
    local target="$1"
    # Only back up real files/dirs, not existing symlinks
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        local rel_path="${target#$HOME/}"
        local backup_dest="$BACKUP_DIR/$rel_path"
        mkdir -p "$(dirname "$backup_dest")"
        mv "$target" "$backup_dest"
        log_warn "Backed up existing ${BOLD}~/$rel_path${RESET} → ${BOLD}$backup_dest${RESET}"
    fi
}

# Create a symlink, backing up any existing real file first.
# Usage: create_symlink /path/to/source /path/to/target
create_symlink() {
    local source="$1"
    local target="$2"

    # Create parent directories
    mkdir -p "$(dirname "$target")"

    # Back up existing real files (not symlinks)
    backup_if_exists "$target"

    # Create the symlink (overwrite existing symlinks)
    ln -sfn "$source" "$target"
    log_success "Linked: ${BOLD}$target${RESET} → ${BOLD}$source${RESET}"
}
