#!/bin/bash

if [ -d "$ZSH" ]; then
	echo "zsh already installed"
else
	echo "installing zsh..."
	sudo apt install -y zsh
	sudo chsh -s $(which zsh)
	sed -i "s/\"robbyrussell\"/\"norm\"/" ~/.zshrc
fi

if [ -d ~/.oh-my-zsh ]; then
	echo "oh-my-zsh already installed"
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions)/" ~/.zshrc
fi

if [ -f ~/z.sh ];then
	echo "z.sh already installed"
else
	echo "installing z.sh"
	wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/z.sh
	echo . ~/z.sh >> ~/.zshrc
fi

if [ -f $(which tmux) ];then
	echo "Tmux already installed"
else
	sudo apt install tmux
fi

source ~/.zshrc


