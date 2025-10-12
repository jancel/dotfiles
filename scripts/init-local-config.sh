#!/usr/bin/env bash
# Initialize local private configuration from templates

set -e

DOTFILES_DIR="${HOME}/.dotfiles"
LOCAL_DIR="${DOTFILES_DIR}/local"
TEMPLATES_DIR="${LOCAL_DIR}/templates"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Initializing local private configuration...${NC}"
echo ""

# Ensure local directory exists
mkdir -p "${LOCAL_DIR}"

# Function to copy template if target doesn't exist
copy_template() {
    local template="$1"
    local target="$2"
    local description="$3"

    if [ -f "$target" ]; then
        echo -e "${YELLOW}⊘${NC} ${description} already exists, skipping"
    else
        cp "$template" "$target"
        echo -e "${GREEN}✓${NC} Created ${description}"
        echo -e "  ${BLUE}→${NC} Edit: ${target}"
    fi
}

# Copy templates
if [ -d "$TEMPLATES_DIR" ]; then
    copy_template \
        "${TEMPLATES_DIR}/local.env.example" \
        "${LOCAL_DIR}/local.env" \
        "local.env (environment variables)"

    copy_template \
        "${TEMPLATES_DIR}/local.aliases.example" \
        "${LOCAL_DIR}/local.aliases" \
        "local.aliases (private aliases)"

    copy_template \
        "${TEMPLATES_DIR}/local.gitconfig.example" \
        "${LOCAL_DIR}/local.gitconfig" \
        "local.gitconfig (git configuration)"
else
    echo -e "${YELLOW}⚠️  Templates directory not found: ${TEMPLATES_DIR}${NC}"
fi

echo ""
echo -e "${GREEN}✓ Local configuration initialized!${NC}"
echo ""
echo "Next steps:"
echo "  1. Edit the files in ${LOCAL_DIR}/ to add your private configuration"
echo "  2. Add your API keys, tokens, and private settings"
echo "  3. These files are gitignored and will never be committed"
echo ""
echo "Examples:"
echo "  ${BLUE}vim ${LOCAL_DIR}/local.env${NC}        # Add environment variables"
echo "  ${BLUE}vim ${LOCAL_DIR}/local.aliases${NC}    # Add private aliases"
echo "  ${BLUE}vim ${LOCAL_DIR}/local.gitconfig${NC}  # Configure git user info"
echo ""
echo "To apply changes, reload your shell:"
echo "  ${BLUE}source ~/.zshrc${NC}  (or source ~/.bashrc)"
echo ""
echo "To verify security:"
echo "  ${BLUE}make verify-security${NC}"
