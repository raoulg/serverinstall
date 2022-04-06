# SERVER SCRIPT
This script can be used to automatically install a bunch of usefull things on a server.

It will:
- do a general update and upgrade
- install ZSH and [oh-my-zsh ](https://github.com/ohmyzsh/ohmyzsh)
- install [pyenv](https://github.com/pyenv/pyenv)
- install python 3.9.12 as a global python version
- install [poetry](https://python-poetry.org)
- install [autojump](https://github.com/wting/autojump)
- install [tmux](https://github.com/tmux/tmux/wiki)

General instructions

    cd ~
    git clone https://github.com/raoulg/serverinstall.git
    . ~/serverinstall/install.sh 
    . ~/serverinstall/settings.sh

If the scripts run succesfully, you will see INSTALL FINISHED SUCCESFULLY or SUCCESFULLY MODIFIED SETTINGS at the end. If not, run again.