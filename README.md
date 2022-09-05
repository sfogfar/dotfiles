# dotfiles-revisited

## Setting up a system from scratch

### Linux

**Note on approach:**
Generally this repo should only contain files that are:
1. Manually written (i.e.: not the consequence of installing some plugin).
2. Fairly universal.

These files should be symlinked directly where they are needed to take effect. In most cases it is not necessary to symlink the entire contents of `.config` or even sub-directories of it and I will prefer to only link the subsets of that directory that I have interacted with most manually.

TODOs:

- fish vi mode
- simplify nvim config

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

#### Fish

1. Install [Fish](https://fishshell.com/).
2. Install [Starship](https://starship.rs/).
3. `ln -s ~/dotfiles/fish ~/.config/fish`

#### Command line comforts

##### fzf

1. Install [fzf](https://github.com/junegunn/fzf#using-git).
2. Install [fzf.fish](https://github.com/PatrickF1/fzf.fish#installation).

##### ripgrep

1. Install [ripgrep](https://github.com/BurntSushi/ripgrep#installation).

##### tree

1. `sudo apt install tree`

#### LibreWolf

1. Install [LibreWolf](https://librewolf.net/).
2. Install [Bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/).
3. Update default browser (under _preferred applications_ in Mint).

#### Font

Install [JetBrains mono](https://www.jetbrains.com/lp/mono/#how-to-install).

#### VS Code

1. Install [VS Code](https://code.visualstudio.com/).
2. Turn on sync.
