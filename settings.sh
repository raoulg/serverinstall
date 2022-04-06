#!/bin/bash

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

