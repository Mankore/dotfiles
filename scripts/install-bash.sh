#!/bin/bash

# ==========================================
# 1. Setup Paths
# ==========================================
# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Assumes script is in /scripts/install.sh, so repo root is one up
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
# Configs folder
CONFIG_DIR="$REPO_ROOT/configs"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}Detected Repo Root: $REPO_ROOT${NC}"
echo -e "${CYAN}Looking for configs in: $CONFIG_DIR${NC}"

# ==========================================
# 2. Helper Function (The Logic)
# ==========================================
link_config() {
    local RELATIVE_PATH="$1"
    local TARGET_PATH="$2"
    local SOURCE_PATH="$CONFIG_DIR/$RELATIVE_PATH"

    echo -e "\n${YELLOW}Processing: $RELATIVE_PATH${NC}"

    # GUARD 1: Source exists?
    if [ ! -e "$SOURCE_PATH" ]; then
        echo -e "${RED}  [!] Source not found in repo: $SOURCE_PATH. Skipping...${NC}"
        return
    fi

    # GUARD 2: Target directory exists?
    local TARGET_DIR
    TARGET_DIR=$(dirname "$TARGET_PATH")
    if [ ! -d "$TARGET_DIR" ]; then
        echo -e "  [+] Creating directory: $TARGET_DIR"
        mkdir -p "$TARGET_DIR"
    fi

    # GUARD 3: Handle existing files/folders
    if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
        # Check if it is a symlink
        if [ -L "$TARGET_PATH" ]; then
            echo -e "  [-] Existing symlink found. Removing old link..."
            rm "$TARGET_PATH"
        else
            echo -e "${GRAY}  [!] Real file/folder exists. Backing up to .bak${NC}"
            # Remove old backup if it exists to allow the move
            if [ -e "${TARGET_PATH}.bak" ]; then
                rm -rf "${TARGET_PATH}.bak"
            fi
            mv "$TARGET_PATH" "${TARGET_PATH}.bak"
        fi
    fi

    # 5. Create the Symlink
    # ln -s = symbolic, -f = force (though we cleaned up manually), -n = no dereference
    ln -s "$SOURCE_PATH" "$TARGET_PATH"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}  [OK] Linked: $SOURCE_PATH -> $TARGET_PATH${NC}"
    else
        echo -e "${RED}  [X] Failed to link.${NC}"
    fi
}

# ==========================================
# 3. Define Mappings & Run
# ==========================================

# SYNTAX: link_config "Folder_In_Repo" "Path_On_System"

# Example 1: Wezterm (Common Mac/Linux path)
link_config "wezterm" "$HOME/.config/wezterm"

# Example 2: Neovim
link_config "nvim" "$HOME/.config/nvim"

# Example 3: Zshrc (Single file example)
# link_config "zshrc" "$HOME/.zshrc"


echo -e "\n${GREEN}Finished! Your environment is now linked.${NC}"