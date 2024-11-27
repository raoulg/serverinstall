# SERVER SCRIPT
This script can be used to automatically install a bunch of usefull things on a server.

# General
For general servers, use this:
```sh
curl -sSL https://raw.githubusercontent.com/raoulg/serverinstall/refs/heads/master/generalserver.sh | bash
```

It will install:
- `curl wget gpg ripgrep fzy unzip fontconfig zsh`
- https://github.com/eza-community/eza
- oh-my-zsh https://ohmyz.sh
- zoxide https://github.com/ajeetdsouza/zoxide
- starship plus nerdfonts https://starship.rs
- rye https://rye.astral.sh 
- add some useful aliases to the `~/.zshrc` file

# Docker
for setting up docker
```sh
curl -sSL https://raw.githubusercontent.com/raoulg/serverinstall/refs/heads/master/install-docker.sh | bash
```

# Personal
This is my personalized setup; it will also set my github username and install my [neovim config](https://github.com/raoulg/neovim).
```sh
curl -sSL https://raw.githubusercontent.com/raoulg/serverinstall/refs/heads/master/serversetup.sh | bash
```
