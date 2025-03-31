#!/bin/bash
set -e

# Get user input FIRST, before any sudo commands
echo "Starting server setup..."

# Store the values
export setup_name="Raoul Grouls"
export setup_email="Raoul.Grouls@han.nl"

# Install basic dependencies
echo "Installing basic dependencies..."
sudo apt update
sudo apt install -y curl wget gpg ripgrep fzy unzip fontconfig zsh

# Install eza
echo "Installing eza..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# Install oh-my-zsh and plugins (with redirected output)
echo "Installing oh-my-zsh and plugins..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zoxide
echo "Installing zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Install Nerd Fonts
echo "Installing Nerd Fonts..."
mkdir -p ~/.fonts
cd ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
unzip FiraCode.zip
fc-cache -f -v

# Install starship
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config
starship preset nerd-font-symbols > ~/.config/starship.toml


# install nvim 0.10
curl -LO https://github.com/neovim/neovim/releases/download/v0.10.0/nvim.appimage
chmod u+x nvim.appimage


# Install Neovim config
echo "Installing Neovim configuration..."
curl -sSL https://raw.githubusercontent.com/raoulg/neovim/main/install-nvim.sh | bash

# Install Rye
echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Configure Git using stored values
echo "Configuring Git..."
git config --global user.name "${setup_name}"
git config --global user.email "${setup_email}"

# Configure zsh (append to existing .zshrc)
echo "Configuring zsh..."
cat >> ~/.zshrc << 'EOL'

# Custom configuration added by setup script
# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Evaluations
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

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

# Terminal configuration
TERM=xterm-256color
bindkey "^[[3~" delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^?' backward-delete-char
EOL

# Add zsh to allowed shells and set as default
echo "Setting zsh as default shell..."
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER

echo "Setup complete! Please log out and back in to use your new zsh configuration."
