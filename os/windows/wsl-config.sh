#!/usr/bin/env bash
# WSL-specific configuration

echo "Configuring WSL environment..."

# Set up Windows interop
export WINDOWS_USER=$(powershell.exe -Command "Write-Host -NoNewline \$env:USERNAME" 2>/dev/null | tr -d '\r')
export WINDOWS_HOME=$(wslpath "$(powershell.exe -Command "Write-Host -NoNewline \$env:USERPROFILE" 2>/dev/null | tr -d '\r')")

# Create .wslconfig if it doesn't exist (for WSL 2)
WSLCONFIG="${WINDOWS_HOME}/.wslconfig"
if [ ! -f "$WSLCONFIG" ]; then
    cat > /tmp/wslconfig << 'EOF'
[wsl2]
memory=4GB
processors=2
swap=2GB

[interop]
enabled=true
appendWindowsPath=true
EOF
    echo "Created .wslconfig template at: $WSLCONFIG"
    echo "You may need to copy /tmp/wslconfig to your Windows home directory"
fi

# Configure git to use Windows credential manager
if command -v git &> /dev/null; then
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe" 2>/dev/null || true
fi

# Set up VS Code integration
if [ -f "/mnt/c/Program Files/Microsoft VS Code/bin/code" ]; then
    alias code="/mnt/c/Program\ Files/Microsoft\ VS\ Code/bin/code"
elif [ -f "/mnt/c/Users/${WINDOWS_USER}/AppData/Local/Programs/Microsoft VS Code/bin/code" ]; then
    alias code="/mnt/c/Users/${WINDOWS_USER}/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
fi

# Add WSL-specific aliases to shell config
cat >> "${HOME}/.aliases" << 'EOF'

# WSL-specific aliases
alias explorer='explorer.exe'
alias open='explorer.exe'
alias winget='winget.exe'
alias powershell='powershell.exe'
alias cmd='cmd.exe'
EOF

echo "✓ WSL configuration complete"
