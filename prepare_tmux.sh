#!/bin/bash

if ! command -v tmux &> /dev/null; then
    echo "tmux not found, installing..."
    brew install tmux
else
    echo "tmux is already installed, skipping installation."
fi

echo "Copying tmux configuration..."
cp ./.tmux.conf ~/.tmux.conf
echo "Done."
