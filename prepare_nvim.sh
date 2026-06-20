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

echo "Copying nvim configuration..."
cp -r ./nvim/config ~/.config/nvim
cp -r ./nvim/local/nvim ~/.local/share/nvim
echo "Done."
