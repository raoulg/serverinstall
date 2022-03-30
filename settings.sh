#!/bin/bash

echo "adding plugins"
omz plugin enable zsh-autosuggestions
omz plugin enable tmux
omz plugin enable autojump
omz theme set norm
omz reload
