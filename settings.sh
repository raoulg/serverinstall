#!/bin/bash

mkdir $ZSH_CUSTOM/plugins/pdm
pdm completion zsh > $ZSH_CUSTOM/plugins/pdm/_pdm

echo "adding plugins"
omz plugin enable zsh-autosuggestions pdm
echo "setting theme"
omz theme set norm
omz reload
echo "SUCCESFULLY MODIFIED SETTINGS"

