#!/usr/bin/env sh
# Secure logging system for dotfiles
# Respects DOTFILES_LOG_LEVEL environment variable
# Compatible with both bash and zsh

# Log levels
readonly LOG_LEVEL_NONE=0
readonly LOG_LEVEL_ERROR=1
readonly LOG_LEVEL_WARN=2
readonly LOG_LEVEL_INFO=3
readonly LOG_LEVEL_DEBUG=4

# Default log level (INFO)
DOTFILES_CURRENT_LOG_LEVEL=${LOG_LEVEL_INFO}

# Parse DOTFILES_LOG_LEVEL environment variable
case "${DOTFILES_LOG_LEVEL:-info}" in
    none|NONE)
        DOTFILES_CURRENT_LOG_LEVEL=${LOG_LEVEL_NONE}
        ;;
    error|ERROR)
        DOTFILES_CURRENT_LOG_LEVEL=${LOG_LEVEL_ERROR}
        ;;
    warn|WARN|warning|WARNING)
        DOTFILES_CURRENT_LOG_LEVEL=${LOG_LEVEL_WARN}
        ;;
    info|INFO)
        DOTFILES_CURRENT_LOG_LEVEL=${LOG_LEVEL_INFO}
        ;;
    debug|DEBUG)
        DOTFILES_CURRENT_LOG_LEVEL=${LOG_LEVEL_DEBUG}
        ;;
esac

# Logging functions
dotfiles_log_error() {
    if [ ${DOTFILES_CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_ERROR} ]; then
        echo "[ERROR] $*" >&2
    fi
}

dotfiles_log_warn() {
    if [ ${DOTFILES_CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_WARN} ]; then
        echo "[WARN] $*" >&2
    fi
}

dotfiles_log_info() {
    if [ ${DOTFILES_CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_INFO} ]; then
        echo "[INFO] $*"
    fi
}

dotfiles_log_debug() {
    if [ ${DOTFILES_CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_DEBUG} ]; then
        echo "[DEBUG] $*"
    fi
}

# Secure source function - loads files without logging their content
# Usage: dotfiles_secure_source "/path/to/file" "description"
dotfiles_secure_source() {
    local file="$1"
    local description="${2:-local configuration}"

    if [ -f "$file" ]; then
        dotfiles_log_debug "Loading ${description} from: $file"

        # Source the file
        # shellcheck disable=SC1090
        if source "$file" 2>/dev/null; then
            dotfiles_log_debug "Successfully loaded ${description}"
            return 0
        else
            dotfiles_log_error "Failed to load ${description} from: $file"
            return 1
        fi
    else
        dotfiles_log_debug "Skipping ${description} - file not found: $file"
        return 0
    fi
}

# Mask sensitive values in output (for debug mode)
# Usage: dotfiles_mask_sensitive "MY_SECRET_VAR"
dotfiles_mask_sensitive() {
    local var_name="$1"
    local var_value="${!var_name}"

    if [ -n "$var_value" ]; then
        local masked="${var_value:0:4}$( printf '*%.0s' {1..8} )"
        dotfiles_log_debug "$var_name is set (masked: ${masked})"
    else
        dotfiles_log_debug "$var_name is not set"
    fi
}

# Functions are now available in the current shell
# Note: In zsh, functions are automatically available to the current shell
# and subshells when sourced. The 'export -f' syntax is bash-specific
# and not needed here.
