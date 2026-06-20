#!/bin/bash

# Check and install nvim
if ! command -v nvim &> /dev/null; then
    echo "nvim not found, installing..."
    brew install nvim
else
    echo "nvim is already installed, skipping."
fi

# Check and install xclip
if ! command -v xclip &> /dev/null; then
    echo "xclip not found, installing..."
    brew install xclip
else
    echo "xclip is already installed, skipping."
fi

# Back up existing configurations
time="$(date +%Y%m%d%H%M%S)"
if [ -d ~/.config/nvim ]; then
    echo "Backing up ~/.config/nvim to ~/.config/nvim_$time"
    mv ~/.config/nvim ~/.config/nvim_$time
fi

if [ -d ~/.local/share/nvim ]; then
    echo "Backing up ~/.local/share/nvim to ~/.local/share/nvim_$time"
    mv ~/.local/share/nvim ~/.local/share/nvim_$time
fi

# Create directories if they don't exist
mkdir -p ~/.config
mkdir -p ~/.local/share

# Install Packer plugin manager
PACKER_DIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [ ! -d "$PACKER_DIR" ]; then
    echo "Installing Packer plugin manager..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
else
    echo "Packer is already installed."
fi

echo "Copying nvim configuration..."
cp -r ./nvim/config ~/.config/nvim
echo "Done. When you first open nvim, run :PackerSync to install your plugins."
