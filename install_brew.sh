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

append_if_not_exists 'export HOMEBREW_NO_AUTO_UPDATE=true'

# Ensure Homebrew is up to date
echo "Optimizing Homebrew for API mode (untapping massive legacy git repos)..."
brew untap homebrew/core 2>/dev/null || true
brew untap homebrew/cask 2>/dev/null || true
brew untap homebrew/cask-fonts 2>/dev/null || true
brew untap homebrew/cask-versions 2>/dev/null || true
brew untap homebrew/command-not-found 2>/dev/null || true
brew untap homebrew/homebrew-cask-drivers 2>/dev/null || true
brew untap homebrew/cask-drivers 2>/dev/null || true

echo "🧹 正在清理残留的国内镜像配置，强制恢复官方 GitHub 源..."
# 1. 恢复核心库和常用 tap 的源
git -C /opt/homebrew remote set-url origin https://github.com/Homebrew/brew 2>/dev/null || true
git -C /opt/homebrew/Library/Taps/homebrew/homebrew-services remote set-url origin https://github.com/Homebrew/homebrew-services 2>/dev/null || true

# 2. 清除当前脚本运行环境中的镜像变量
unset HOMEBREW_API_DOMAIN
unset HOMEBREW_BOTTLE_DOMAIN
unset HOMEBREW_BREW_GIT_REMOTE
unset HOMEBREW_CORE_GIT_REMOTE

echo "Updating Homebrew..."
brew update

# Ensure GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "Installing GitHub CLI (gh)..."
    brew install gh
else
    echo "✅ GitHub CLI (gh) is already installed."
fi

# Ensure iTerm2 is installed
if [ ! -d "/Applications/iTerm.app" ]; then
    echo "Installing iTerm2..."
    brew install --cask iterm2
else
    echo "✅ iTerm2 is already installed."
fi

echo "Brew and essential CLI tools configuration completed."
