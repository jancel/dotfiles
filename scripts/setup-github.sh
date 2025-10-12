#!/usr/bin/env bash
# Interactive GitHub configuration setup

set -e

LOCAL_DIR="${HOME}/.dotfiles/local"
GITCONFIG="${LOCAL_DIR}/local.gitconfig"
ENV_FILE="${LOCAL_DIR}/local.env"
ALIASES_FILE="${LOCAL_DIR}/local.aliases"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}GitHub Configuration Setup${NC}"
echo "======================================"
echo ""

# Check if local config exists
if [ ! -d "$LOCAL_DIR" ]; then
    echo -e "${YELLOW}Local configuration not initialized. Running init-local...${NC}"
    make -C ~/.dotfiles init-local
fi

echo "This script will help you configure GitHub access."
echo ""

# Git user information
echo -e "${BLUE}Step 1: Git User Information${NC}"
echo "-----------------------------------"
read -p "Your full name: " git_name
read -p "Your email: " git_email
read -p "Your GitHub username: " github_user

# Backup existing config
if [ -f "$GITCONFIG" ]; then
    cp "$GITCONFIG" "${GITCONFIG}.backup"
fi

# Write git config
cat > "$GITCONFIG" << EOF
[user]
    name = ${git_name}
    email = ${git_email}

[github]
    user = ${github_user}

[credential]
    helper = osxkeychain  # macOS - stores credentials in Keychain

# Uncomment for commit signing (requires GPG key)
# [commit]
#     gpgsign = true
# [user]
#     signingkey = YOUR_GPG_KEY_ID
EOF

echo -e "${GREEN}✓${NC} Git configuration written to ${GITCONFIG}"
echo ""

# Authentication method
echo -e "${BLUE}Step 2: Authentication Method${NC}"
echo "-----------------------------------"
echo "Choose your preferred authentication method:"
echo "  1) Personal Access Token (HTTPS)"
echo "  2) SSH Keys"
echo "  3) GitHub CLI (gh)"
echo "  4) Skip (configure later)"
echo ""
read -p "Choice [1-4]: " auth_choice

case $auth_choice in
    1)
        echo ""
        echo -e "${YELLOW}Personal Access Token Setup${NC}"
        echo "1. Go to: https://github.com/settings/tokens"
        echo "2. Click 'Generate new token (classic)'"
        echo "3. Select scopes: repo, workflow, write:packages"
        echo "4. Copy the token (you won't see it again!)"
        echo ""
        read -p "Paste your token (input hidden): " -s github_token
        echo ""

        if [ -n "$github_token" ]; then
            # Backup existing env file
            if [ -f "$ENV_FILE" ]; then
                cp "$ENV_FILE" "${ENV_FILE}.backup"
            fi

            # Add token to env file
            if ! grep -q "GITHUB_TOKEN" "$ENV_FILE" 2>/dev/null; then
                echo "" >> "$ENV_FILE"
                echo "# GitHub Personal Access Token" >> "$ENV_FILE"
                echo "export GITHUB_TOKEN=\"${github_token}\"" >> "$ENV_FILE"
            else
                # Update existing token
                sed -i.bak "s/^export GITHUB_TOKEN=.*/export GITHUB_TOKEN=\"${github_token}\"/" "$ENV_FILE"
            fi

            echo -e "${GREEN}✓${NC} Token added to ${ENV_FILE}"
        fi
        ;;
    2)
        echo ""
        echo -e "${YELLOW}SSH Key Setup${NC}"

        if [ -f ~/.ssh/id_ed25519.pub ]; then
            echo -e "${GREEN}✓${NC} SSH key already exists: ~/.ssh/id_ed25519"
            echo ""
            echo "Your public key:"
            cat ~/.ssh/id_ed25519.pub
            echo ""
            echo "Copy the above key and add it to GitHub:"
            echo "  https://github.com/settings/keys"
        else
            echo "Generating new SSH key..."
            ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519

            # Add to ssh-agent
            eval "$(ssh-agent -s)"
            ssh-add ~/.ssh/id_ed25519

            echo ""
            echo -e "${GREEN}✓${NC} SSH key generated!"
            echo ""
            echo "Your public key:"
            cat ~/.ssh/id_ed25519.pub
            echo ""
            echo "Add this key to GitHub:"
            echo "  https://github.com/settings/keys"
        fi

        # Test SSH connection
        echo ""
        read -p "Press Enter to test SSH connection to GitHub..."
        if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
            echo -e "${GREEN}✓${NC} SSH authentication successful!"
        else
            echo -e "${YELLOW}⚠${NC}  SSH test failed. Make sure you've added the key to GitHub."
        fi
        ;;
    3)
        echo ""
        echo -e "${YELLOW}GitHub CLI Setup${NC}"

        if ! command -v gh &> /dev/null; then
            echo "GitHub CLI not found. Installing..."
            if [[ "$OSTYPE" == "darwin"* ]]; then
                brew install gh
            else
                echo "Please install GitHub CLI manually:"
                echo "  https://cli.github.com/"
                exit 1
            fi
        fi

        echo "Authenticating with GitHub CLI..."
        gh auth login

        echo -e "${GREEN}✓${NC} GitHub CLI configured!"
        ;;
    4)
        echo "Skipping authentication setup."
        echo "See ${LOCAL_DIR}/GITHUB_SETUP.md for manual setup instructions."
        ;;
esac

echo ""
echo -e "${BLUE}Step 3: Useful Aliases${NC}"
echo "-----------------------------------"

# Add useful aliases
cat >> "$ALIASES_FILE" << 'EOF'

# Git shortcuts
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gc='git commit'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# GitHub CLI shortcuts (if using gh)
alias ghpr='gh pr create'
alias ghpv='gh pr view'
alias ghpl='gh pr list'
alias ghrc='gh repo clone'
EOF

echo -e "${GREEN}✓${NC} Aliases added to ${ALIASES_FILE}"

echo ""
echo -e "${GREEN}Setup Complete!${NC}"
echo "======================================"
echo ""
echo "Next steps:"
echo "  1. Reload your shell:"
echo -e "     ${BLUE}source ~/.zshrc${NC}"
echo ""
echo "  2. Test your configuration:"
echo -e "     ${BLUE}git config --list | grep user${NC}"
echo ""
echo "  3. Try cloning a repo:"
echo -e "     ${BLUE}git clone https://github.com/username/repo.git${NC}"
echo ""
echo "For detailed documentation, see:"
echo "  ${LOCAL_DIR}/GITHUB_SETUP.md"
echo ""
echo "To verify security:"
echo -e "  ${BLUE}make verify-security${NC}"
