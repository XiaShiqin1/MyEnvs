#!/bin/bash

if command -v brew &> /dev/null; then
    echo "Brew is already installed, skipping installation."
else
    echo "Brew is not installed. Please uncomment the installation lines in this script if you need to install it."
    # xcode-select --install
    # export HOMEBREW_INSTALL_FROM_API=1
    # export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    # export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    # export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    # export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"

    # git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
    # /bin/bash brew-install/install.sh
    # rm -rf brew-install
fi

if test -w ~/.zshrc; then
    echo "~/.zshrc writable"
else
    touch ~/.zshrc
fi

# Function to safely append if not exists
append_if_not_exists() {
    grep -qF "$1" ~/.zshrc || echo "$1" >> ~/.zshrc
}

append_if_not_exists 'eval "$(/opt/homebrew/bin/brew shellenv)"'
append_if_not_exists 'export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"'
append_if_not_exists 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"'
append_if_not_exists 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"'
append_if_not_exists 'export HOMEBREW_NO_AUTO_UPDATE=true'

echo "Brew env configuration checked/updated."
