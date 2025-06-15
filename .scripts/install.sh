#!/bin/bash

# ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
# ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
# ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
# ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
# ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
# ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝

# ═══════════════════════════════════════════════════════════
# ░ vxVim INSTALLATION SCRIPT
# ═══════════════════════════════════════════════════════════

set -e

# ╭─ COLORS ───────────────────────────────────────────────╮
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# ╭─ CONFIGURATION ────────────────────────────────────────╮
REPO_URL="https://github.com/v88x/vxVim.git"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"

# ╭─ FUNCTIONS ────────────────────────────────────────────╮
print_header() {
    echo -e "${PURPLE}"
    echo "██╗   ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
    echo "██║   ██║╚██╗██╔╝██║   ██║██║████╗ ████║"
    echo "██║   ██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
    echo "╚██╗ ██╔╝ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
    echo " ╚████╔╝ ██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
    echo "  ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
    echo -e "${NC}"
    echo -e "${CYAN}Modern Neovim Configuration${NC}"
    echo ""
}

print_step() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_dependencies() {
    print_step "Checking dependencies..."
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed. Please install git first."
        exit 1
    fi
    
    # Check if nvim is installed
    if ! command -v nvim &> /dev/null; then
        print_error "Neovim is not installed. Please install Neovim first."
        echo "Visit: https://github.com/neovim/neovim/releases"
        exit 1
    fi
    
    # Check Neovim version
    local nvim_version=$(nvim --version | head -n1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+')
    local required_version="v0.9.0"
    
    if [[ "$(printf '%s\n' "$required_version" "$nvim_version" | sort -V | head -n1)" != "$required_version" ]]; then
        print_error "Neovim version $nvim_version is too old. Required: $required_version or newer."
        exit 1
    fi
    
    print_success "All dependencies are satisfied"
}

backup_existing_config() {
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        print_step "Backing up existing Neovim configuration..."
        mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
        print_success "Backup created at: $BACKUP_DIR"
    fi
}

clean_local_cache() {
    print_step "Cleaning Neovim local cache..."
    
    # Remove cache directories
    [ -d "$HOME/.local/share/nvim" ] && rm -rf "$HOME/.local/share/nvim"
    [ -d "$HOME/.local/state/nvim" ] && rm -rf "$HOME/.local/state/nvim"
    [ -d "$HOME/.cache/nvim" ] && rm -rf "$HOME/.cache/nvim"
    
    print_success "Local cache cleaned"
}

clone_config() {
    print_step "Cloning vxVim configuration..."
    git clone "$REPO_URL" "$NVIM_CONFIG_DIR"
    print_success "Configuration cloned successfully"
}

install_dependencies() {
    print_step "Installing dependencies..."
    
    # Update system is now built into Lua - no separate script needed
    
    print_success "Dependencies installed"
}

setup_auto_update() {
    print_step "Setting up auto-update system..."
    
    # Create version tracking
    echo "$(date +%s)" > "$NVIM_CONFIG_DIR/.last_update_check"
    
    print_success "Auto-update system configured"
}

main() {
    print_header
    
    echo -e "${WHITE}Installing vxVim configuration for Neovim...${NC}"
    echo ""
    
    check_dependencies
    backup_existing_config
    clean_local_cache
    clone_config
    install_dependencies
    setup_auto_update
    
    echo ""
    print_success "vxVim installation completed!"
    echo ""
    echo -e "${CYAN}Next steps:${NC}"
    echo "1. Start Neovim: ${WHITE}nvim${NC}"
    echo "2. Wait for plugins to install automatically"
    echo "3. Restart Neovim after installation"
    echo ""
    echo -e "${CYAN}Update commands:${NC} ${WHITE}:VxVimUpdate${NC} or press ${WHITE}u${NC} in dashboard"
    echo ""
    echo -e "${YELLOW}Note:${NC} First startup may take a few minutes to install plugins."
}

main "$@" 