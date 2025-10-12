#!/usr/bin/env bash
# Verify that sensitive files are properly gitignored

set -e

DOTFILES_DIR="${HOME}/.dotfiles"
FAILED=0

echo "Verifying dotfiles security configuration..."
echo ""

# Check if .gitignore exists
if [ ! -f "${DOTFILES_DIR}/.gitignore" ]; then
    echo "❌ .gitignore not found!"
    FAILED=1
else
    echo "✓ .gitignore exists"
fi

# Check that local/ is in .gitignore
if ! grep -q "^local/" "${DOTFILES_DIR}/.gitignore" 2>/dev/null; then
    echo "❌ local/ directory not in .gitignore!"
    FAILED=1
else
    echo "✓ local/ directory is gitignored"
fi

# Check for accidentally tracked sensitive files
cd "${DOTFILES_DIR}"
TRACKED_SECRETS=$(git ls-files | grep -E "(secret|password|credential|token|\.key$|\.pem$|local\.)" || true)

if [ -n "$TRACKED_SECRETS" ]; then
    echo "❌ WARNING: Potentially sensitive files are tracked in git:"
    echo "$TRACKED_SECRETS"
    echo ""
    echo "To remove from git (but keep locally):"
    echo "  git rm --cached <filename>"
    FAILED=1
else
    echo "✓ No sensitive files tracked in git"
fi

# Check if local directory exists and has templates
if [ ! -d "${DOTFILES_DIR}/local/templates" ]; then
    echo "⚠️  local/templates directory not found"
else
    echo "✓ local/templates directory exists"
fi

# Check if secure logger exists
if [ ! -f "${DOTFILES_DIR}/scripts/secure-logger.sh" ]; then
    echo "❌ secure-logger.sh not found!"
    FAILED=1
else
    echo "✓ secure-logger.sh exists"
fi

# Test secure logger
if [ -f "${DOTFILES_DIR}/scripts/secure-logger.sh" ]; then
    source "${DOTFILES_DIR}/scripts/secure-logger.sh"

    # Test that debug logging is off by default
    export DOTFILES_LOG_LEVEL=none
    OUTPUT=$(dotfiles_log_debug "test" 2>&1 || true)
    if [ -n "$OUTPUT" ]; then
        echo "⚠️  Debug logging may not be properly suppressed"
    else
        echo "✓ Logging system working correctly"
    fi
fi

echo ""
if [ $FAILED -eq 0 ]; then
    echo "✅ All security checks passed!"
    exit 0
else
    echo "❌ Security verification failed!"
    echo ""
    echo "Please review and fix the issues above before committing."
    exit 1
fi
