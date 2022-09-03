# dotfiles-revisited

## Setting up a system from scratch

### Linux

TODOs:

- nvim
- simplify nvim config
- zsh / fish
- vim terminal commands
- prompt
- git
- browser

Suggested sequence:

1. Get git and connect to GitHub.
2. Clone this repo.

#### Git

1. `sudo apt install git`
2. [Connect to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
3. `ln -s ~/dotfiles/git/gitconfig ~/.gitconfig`
4. `ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global`

#### Neovim

1. Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#linux).
2. Install [vim plug](https://github.com/junegunn/vim-plug#unix-linux).
3. `ln -s ~/dotfiles/nvim ~/.config/nvim`
4. `:PlugInstall`

#### Kitty

1. Install [Kitty](https://sw.kovidgoyal.net/kitty/) & add to desktop.
2. `ln -s ~/dotfiles/kitty ~/.config/kitty`

#### Font

Install [JetBrains mono](https://www.jetbrains.com/lp/mono/#how-to-install).

#### VS Code

1. Install [VS Code](https://code.visualstudio.com/).
2. Turn on sync.
