# PowerShell script to install dotfiles in WSL
# Run this from Windows PowerShell

Write-Host "Installing dotfiles in WSL..." -ForegroundColor Green

# Check if WSL is installed
$wslCheck = wsl --list --quiet 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "WSL is not installed. Installing WSL..." -ForegroundColor Yellow
    Write-Host "This requires administrator privileges and a restart." -ForegroundColor Yellow

    # Check if running as administrator
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $isAdmin) {
        Write-Host "Please run this script as Administrator to install WSL." -ForegroundColor Red
        Write-Host "Right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
        exit 1
    }

    wsl --install
    Write-Host ""
    Write-Host "WSL has been installed. Please restart your computer and run this script again." -ForegroundColor Green
    exit 0
}

# Install dotfiles in WSL
Write-Host "Installing dotfiles in WSL default distribution..." -ForegroundColor Green
wsl bash -c "curl -fsSL https://raw.githubusercontent.com/jancel/dotfiles/main/install.sh | bash"

Write-Host ""
Write-Host "Dotfiles installed successfully!" -ForegroundColor Green
Write-Host "To use your new shell configuration, restart your WSL terminal or run:" -ForegroundColor Cyan
Write-Host "  wsl source ~/.zshrc" -ForegroundColor White
