#!/usr/bin/env bash
# Initialize a devcontainer in the current directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
DEVCONTAINER_TEMPLATE="$DOTFILES_DIR/config/devcontainer"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if .devcontainer already exists
if [ -d ".devcontainer" ]; then
    echo -e "${YELLOW}Warning: .devcontainer directory already exists in current directory${NC}"
    read -p "Overwrite? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    rm -rf .devcontainer
fi

# Create .devcontainer directory
mkdir -p .devcontainer

# Copy devcontainer files
echo -e "${GREEN}Creating devcontainer configuration...${NC}"
cp "$DEVCONTAINER_TEMPLATE/devcontainer.json" .devcontainer/
cp "$DEVCONTAINER_TEMPLATE/Dockerfile" .devcontainer/

echo -e "${GREEN}✓ Devcontainer created successfully in $(pwd)/.devcontainer${NC}"
echo ""
echo "Next steps:"
echo "  1. (Optional) Customize .devcontainer/devcontainer.json and .devcontainer/Dockerfile"
echo "  2. Open the command palette (Cmd+Shift+P / Ctrl+Shift+P)"
echo "  3. Select 'Dev Containers: Reopen in Container'"
echo ""
echo -e "${GREEN}Your dotfiles will be automatically cloned and installed from GitHub!${NC}"
echo "  Repository: https://github.com/jancel/dotfiles.git"
echo "  Branch: main"
