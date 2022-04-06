#!/bin/bash

if [ -d ~/.oh-my-zsh ]; then
	echo "oh-my-zsh already installed"
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
	echo "autosuggestions already installed"
else
	echo "installing autosuggestions"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ -d $ZSH_CUSTOM/plugins/poetry ]; then
	echo "poetry completions already added to zsh"
else
	echo "adding poetry completions to zsh"
	mkdir $ZSH_CUSTOM/plugins/poetry
	poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
fi

echo "adding plugins"
omz plugin enable zsh-autosuggestions tmux autojump poetry
echo "setting theme"
omz theme set norm
omz reload
echo "SUCCESFULLY MODIFIED SETTINGS"

