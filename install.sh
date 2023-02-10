#!/bin/bash

sudo apt -y update && sudo apt -y upgrade
sudo apt -y update ; sudo apt -y install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev


if [ -d ~/.pyenv ]; then
	echo "Pyenv already installed"
else
	echo "Installing pyenv"
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

if [ -d "$ZSH" ]; then
	echo "zsh already installed"
else
	echo "installing zsh..."
	sudo apt install -y zsh
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
	echo 'eval "$(pyenv init --path)"' >> ~/.zprofile

	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
	echo 'eval "$(pyenv init --path)"' >> ~/.profile
	echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi

if [ -d ~/.oh-my-zsh ]; then
	echo "oh-my-zsh already installed"
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
	echo "autosuggestions already installed"
else
	echo "installing autosuggestions"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ $(pyenv versions) == *"3.10.9"* ]]; then
	echo "Python version 3.10.9 already installed"
else
	pyenv install 3.10.9
fi
pyenv global 3.10.9

if [ -f $(which poetry) ]; then 
	echo "Poetry already installed"
else
	curl -sSL https://install.python-poetry.org | python -
	echo 'export PATH="$HOME/.local/bin${PATH:+:${PATH}}"' >> ~/.zshrc
fi

if [ -f $(which zoxide) ]; then 
	echo "zoxide installed"
else
	curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
	echo 'eval "$(pyenv init -)"' >> ~/.zshrc
	echo "zoxide installed"
fi

if [ -f $(which exa	) ]; then 
	echo "exa already installed"
else
	sudo apt install exa
	echo "alias lsd='exa -h --icons --long --sort=mod'" >> ~/.zshrc
fi

if [ -f $(which fontconfig) ]; then 
	echo "fontconfig installed"
else
	sudo apt install unzip
	sudo apt install fontconfig
	mkdir ~/.fonts
	cd ~/.fonts
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
	unzip FiraCode.zip
	fc-cache -f -v
	echo "fontconfig installed"
fi

if [ -f $(which starship) ]; then 
	echo "starship installed"
else
	curl -ss https://starship.rs/install.sh | sh
	echo 'eval "$(pyenv init -)"' >> ~/.zshrc
	echo 'eval "$(starship init zsh)"' >> ~/.zshrc
	starship preset nerd-font-symbols > ~/.config/starship.toml

	echo "starship installed"
fi

if [ -f $(which nvim) ]; then 
	echo "neovim installed"
else
	sudo apt install snapd
	sudo snap install nvim --classic

	echo "neovim installed"
fi





COUNTER=0
if [ -d ~/.pyenv ]; then
	let COUNTER++
fi
if [ -d "$ZSH" ]; then
	let COUNTER++
fi
if [ -d ~/.oh-my-zsh ]; then
	let COUNTER++
fi
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
	let COUNTER++
fi
if [[ $(pyenv versions) == *"3.9.12"* ]]; then
	let COUNTER++
fi
if [ -f $(which poetry) ]; then 
	let COUNTER++
fi
echo "Installed ${COUNTER}/6 items succesfully"

sudo chsh -s $(which zsh)
source ~/.zshrc
