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
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
	echo 'eval "$(pyenv init --path)"' >> ~/.zprofile

	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
	echo 'eval "$(pyenv init --path)"' >> ~/.profile
	echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi

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

if [[ $(pyenv versions) == *"3.9.12"* ]]; then
	echo "Python version 3.9.12 already installed"
else
	pyenv install 3.9.12
fi
pyenv global 3.9.12
curl -sSL https://install.python-poetry.org | python -
echo 'export PATH="$HOME/.local/bin${PATH:+:${PATH}}"' >> ~/.zshrc

exec zsh
source ~/.zshrc
