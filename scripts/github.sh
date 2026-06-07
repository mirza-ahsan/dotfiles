#!/bin/bash
set -e

# ── Source shared library ─────────────────────────────────────────────────────
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/lib.sh"

log_section "GitHub SSH Key Setup"

KEY_PATH="$HOME/.ssh/id_ed25519"

# Skip if key already exists
if [ -f "$KEY_PATH" ]; then
    log_success "SSH key already exists at ${BOLD}$KEY_PATH${RESET}. Skipping generation."
    echo ""
    log_info "Your existing public key:"
    echo "───────────────────────────────────────────────────────"
    cat "${KEY_PATH}.pub"
    echo "───────────────────────────────────────────────────────"
    exit 0
fi

# Prompt for email
echo ""
read -rp "$(echo -e "${BLUE}[INPUT]${RESET}   Enter your GitHub email: ")" EMAIL

if [ -z "$EMAIL" ]; then
    log_error "Email cannot be empty. Aborting SSH key setup."
    exit 1
fi

# Generate key
log_info "Generating SSH key for ${BOLD}$EMAIL${RESET}..."
mkdir -p "$HOME/.ssh"
ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""

# Start SSH agent and add key
log_info "Starting SSH agent..."
eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add "$KEY_PATH"

# Show the public key
echo ""
log_success "SSH key generated! Copy the public key below and add it to GitHub:"
echo "───────────────────────────────────────────────────────"
cat "${KEY_PATH}.pub"
echo "───────────────────────────────────────────────────────"
log_info "Add it at: ${BOLD}https://github.com/settings/ssh/new${RESET}"
