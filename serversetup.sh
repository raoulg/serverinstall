#!/bin/bash

# Exit on error
set -e

echo "Starting server setup..."

# Get email and infer name
read -p "Enter your email address: " email
# Extract name from email (assumes format: firstname.lastname@domain.com or firstname@domain.com)
name=$(echo "$email" | cut -d'@' -f1 | tr '.' ' ' | sed 's/\b\(.\)/\u\1/g')

echo "Setting up git configuration with:"
echo "Name: $name"
echo "Email: $email"
read -p "Is this correct? [Y/n] " confirm
confirm=${confirm:-Y}  # Default to Y if user just hits enter

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    read -p "Enter your preferred name: " name
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install basic dependencies
echo "Installing basic dependencies..."
sudo apt update
sudo apt install -y curl wget gpg ripgrep fzy

# Install eza
echo "Installing eza..."
if ! command_exists eza; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

# Install Neovim config
echo "Installing Neovim configuration..."
curl -sSL https://raw.githubusercontent.com/raoulg/neovim/main/install-nvim.sh | bash

# Install Rye
echo "Installing Rye..."
if ! command_exists rye; then
    curl -sSf https://rye.astral.sh/get | bash
fi

# Configure Git
echo "Configuring Git..."
git config --global user.name "$name"
git config --global user.email "$email"

# Add aliases to .bashrc
echo "Adding aliases to .bashrc..."
cat >> ~/.bashrc << 'EOL'

# Custom aliases
alias gs="git status"
alias lst="ls -tlhr"
alias lsf="du -sh * | sort -sh"
alias hg="history | rg "
alias lsd="eza --icons -l --sort=mod --hyperlink"
alias ss="source .venv/bin/activate"
alias hh="history | tail -n 20"
alias cdi='cd $(ls | fzy)'

# Navigate to directory of file with extension
alias lsi='function _rgfzy() { \
    local ext="$1"; \
    local file=$(rg --files -g "*.${ext}" | fzy); \
    if [[ -n "$file" ]]; then \
        cd "$(dirname "$file")"; \
    fi; \
}; _rgfzy'
EOL

# Source .bashrc to make aliases available immediately
source ~/.bashrc

echo "Setup complete! Please restart your shell or run 'source ~/.bashrc' to use the new aliases."
