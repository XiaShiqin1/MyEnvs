#!/bin/bash

# Install oh-my-zsh if not already installed
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh..."
    # Run the official oh-my-zsh installer unattended
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh is already installed, skipping."
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Install zsh-syntax-highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "zsh-syntax-highlighting already installed, skipping."
fi

# Install zsh-autosuggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "zsh-autosuggestions already installed, skipping."
fi

# Install powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "Installing powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "powerlevel10k already installed, skipping."
fi

# Install fonts on macOS (for powerlevel10k)
if [ "$(uname)" = "Darwin" ]; then
    echo "Checking p10k fonts..."
    FONT_DIR="$HOME/Library/Fonts"
    for font in ./resource/Meslo*.ttf; do
        if [ -f "$font" ]; then
            font_name=$(basename "$font")
            if [ ! -f "$FONT_DIR/$font_name" ]; then
                echo "Installing font: $font_name"
                cp "$font" "$FONT_DIR/"
            else
                echo "Font $font_name already installed, skipping."
            fi
        fi
    done

    # Automatically set Terminal.app font using AppleScript
    echo "Configuring Apple Terminal font..."
    osascript <<EOF
tell application "Terminal"
    -- Set default settings for new windows
    set font name of default settings to "MesloLGS NF"
    set font size of default settings to 14
    
    -- Apply to all currently open windows/tabs
    repeat with w in windows
        repeat with t in tabs of w
            set font name of current settings of t to "MesloLGS NF"
            set font size of current settings of t to 14
        end repeat
    end repeat
end tell
EOF
    echo "Terminal font configured successfully."
fi

# --- Incremental Configuration ---
# Instead of replacing the whole ~/.zshrc, we incrementally modify it

if [ -f ~/.zshrc ]; then
    # Add zsh-syntax-highlighting to plugins if not present
    if ! grep -q "zsh-syntax-highlighting" ~/.zshrc; then
        echo "Adding zsh-syntax-highlighting to plugins in ~/.zshrc..."
        sed -i '' 's/plugins=(/plugins=(zsh-syntax-highlighting /' ~/.zshrc
    fi

    # Add zsh-autosuggestions to plugins if not present
    if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
        echo "Adding zsh-autosuggestions to plugins in ~/.zshrc..."
        sed -i '' 's/plugins=(/plugins=(zsh-autosuggestions /' ~/.zshrc
    fi

    # Set ZSH_THEME to powerlevel10k incrementally
    if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" ~/.zshrc; then
        echo "Setting ZSH_THEME to powerlevel10k in ~/.zshrc..."
        sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
    fi

    # Source local project .zshrc incrementally (for aliases, exports, etc.)
    # We rename the repo's .zshrc to custom_env.zsh to avoid confusion if you like.
    # But if we keep it as .zshrc, we can source it. Since it currently has a full oh-my-zsh config,
    # the user might want to clean it up to only contain incremental configs.
    
    # Check if the source line is already in ~/.zshrc
    CURRENT_DIR=$(pwd)
    if ! grep -q "source $CURRENT_DIR/.zshrc" ~/.zshrc; then
        echo "Appending source command to ~/.zshrc to load local aliases/configs..."
        echo "" >> ~/.zshrc
        echo "# Load custom envs incrementally" >> ~/.zshrc
        echo "if [ -f \"$CURRENT_DIR/.zshrc\" ]; then" >> ~/.zshrc
        echo "    source \"$CURRENT_DIR/.zshrc\"" >> ~/.zshrc
        echo "fi" >> ~/.zshrc
    fi

    # Sync pre-configured p10k config
    if [ -f "$CURRENT_DIR/.p10k.zsh" ]; then
        echo "Syncing pre-configured .p10k.zsh to ~/"
        cp "$CURRENT_DIR/.p10k.zsh" ~/.p10k.zsh
        
        # Ensure ~/.p10k.zsh is sourced in ~/.zshrc
        if ! grep -q "source ~/.p10k.zsh" ~/.zshrc; then
            echo "Appending .p10k.zsh source command to ~/.zshrc..."
            # For p10k, it's best to source it at the top or bottom, standard is usually:
            echo "" >> ~/.zshrc
            echo "# To customize prompt, run \`p10k configure\` or edit ~/.p10k.zsh." >> ~/.zshrc
            echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc
        fi
    fi

else
    echo "Warning: ~/.zshrc not found. Please run zsh once to initialize it."
fi

echo "Done. Please restart your terminal or run 'source ~/.zshrc'."
