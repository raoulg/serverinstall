#!/bin/bash

sudo apt update -y && sudo apt upgrade -y

if [ -d "$ZSH" ]; then
	echo "zsh already installed"
else
	echo "installing zsh..."
	sudo apt install -y zsh
	sudo chsh -s $(which zsh)
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

if [ -f $(which autojump) ]; then
	echo "Autojump already installed"
else
	echo "Installing autojump"
	sudo apt install autojump
fi

if [[ -f $(which tmux) || "$TERM" == "screen" ]]; then
	echo "Tmux already installed"
else
	echo "Installing tmux"
	sudo apt install tmux
fi

source ~/.zshrc


