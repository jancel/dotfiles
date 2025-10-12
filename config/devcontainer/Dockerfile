# Base Debian development container
FROM debian:bookworm-slim

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    # Common utilities
    ca-certificates \
    curl \
    wget \
    git \
    gnupg2 \
    locales \
    sudo \
    vim \
    # Build tools
    build-essential \
    # Additional tools you may need
    openssh-client \
    less \
    iproute2 \
    procps \
    lsof \
    htop \
    net-tools \
    psmisc \
    unzip \
    zip \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

# Set default user
USER $USERNAME
WORKDIR /home/$USERNAME

# Note: Dotfiles are automatically installed by VS Code's built-in dotfiles support
# See devcontainer.json's "dotfiles" configuration
# The dotfiles will be cloned to ~/.dotfiles and install.sh will be executed
