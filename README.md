# SERVER SCRIPT
This script can be used to automatically install a bunch of usefull things on a server.

It will:
- do a general update and upgrade
- install ZSH and [oh-my-zsh ](https://github.com/ohmyzsh/ohmyzsh)
- install [pyenv](https://github.com/pyenv/pyenv)
- install python 3.9.12 as a global python version
- install [pdm](https://pdm-project.org)
- install [autojump](https://github.com/wting/autojump)
- install [tmux](https://github.com/tmux/tmux/wiki)

General instructions

    cd ~
    git clone https://github.com/raoulg/serverinstall.git
    . ~/serverinstall/install.sh 
    . ~/serverinstall/settings.sh

If the scripts run succesfully, you will see INSTALL FINISHED SUCCESFULLY or SUCCESFULLY MODIFIED SETTINGS at the end. If not, run again.

Right now, you will need to run the install.sh script twice:
the first time, it stops after oh-my-zsh is installed.
The second time, it adds the rest.

Removing oh-my-zsh causes problems because the script does not has acces to the
`pyenv` commando yet; the installation of oh-my-zsh triggers has that as a side effect
because of the shell reboot.

If someone has a nice fix for that, let me know :)

```sh
curl -sSL https://raw.githubusercontent.com/raoulg/serverinstall/main/serversetup.sh | bash
```
