#!/bin/bash


echo "adding plugins"
omz plugin enable zsh-autosuggestions
echo "setting theme"
omz theme set norm
omz reload
echo "SUCCESFULLY MODIFIED SETTINGS"

