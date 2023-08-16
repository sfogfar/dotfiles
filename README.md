# dotfiles

My version controlled dotfiles.

## Note on approach

It is preferable to keep this repo simple, with portable dotfiles that can easily be cloned and used to configure essential tooling on any machine, than to have this be heavily automated but temperamental.

As such, this repo will ideally contain only files that are:

1. Manually written (i.e.: not the consequence of installing some plugin).
2. Fairly universal.

These files should be symlinked to where they are needed to take effect.
In most cases it is not necessary to symlink the entire contents of `.config` or even sub-directories of it and I will prefer to only link the subsets of that directory that I have interacted with most manually.

It may sometimes be more appropriate to make notes here on how to configure something, than to try and store the config itself.
For example, VSCode extensions and settings.json are more easily managed by syncing than by using this repo.

## TODOs

- Add descriptions to remaps / register with which-key.
- Bring final vimscript functions across to Lua.
- Add i3 setup instructions for Linux.
- Try and get gui MacOS settings defined in config files.

## Setting up a system from scratch

### Linux or MacOS

#### [macOS] Homebrew

1. Install [Homebrew](https://brew.sh/).

#### Git

1. `sudo apt install git` || `brew install git`
2. [Connect to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
3. `ln -s ~/dotfiles/git/gitconfig ~/.gitconfig`
4. `ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global`

#### Neovim

1. Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#linux).
2. Run `nvim +checkhealth`, making sure to check python and node providers.
3. Install [packer](https://github.com/wbthomason/packer.nvim#quickstart).
4. `ln -s ~/dotfiles/nvim/ ~/.config/nvim/`

_Note:_ Resolved compilation error when installing nvim-treesitter on Linux Mint by running `sudo apt install g++`.

#### Kitty

1. Install [Kitty](https://sw.kovidgoyal.net/kitty/) 
2. [Linux] Add to desktop.
2. `ln -s ~/dotfiles/kitty ~/.config/kitty`

#### Fish

1. Install [Fish](https://fishshell.com/).
2. [macOS] `set -U fish_user_paths /usr/local/bin $fish_user_paths`
3. Install [Starship](https://starship.rs/).
4. `ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish`
5. `ln -s ~/dotfiles/fish/functions ~/.config/fish/functions`
6. `ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml`
7. `fish_config` to set the theme.

#### Command line comforts

1. Install [fzf](https://github.com/junegunn/fzf#using-git).
2. Install [fzf.fish](https://github.com/PatrickF1/fzf.fish#installation).
3. Install [ripgrep](https://github.com/BurntSushi/ripgrep#installation).
4. Install [fd](https://github.com/BurntSushi/ripgrep#installation).

##### tree

1. `sudo apt install tree` || `brew install tree`

#### Browser

##### LibreWolf

For general browsing with excellent privacy.

1. Install [LibreWolf](https://librewolf.net/).
2. Install [Bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/).
3. Update default browser (under _preferred applications_ in Mint).

##### Brave

For the sites that only work properly on Chrome.

1. Install [Brave](https://brave.com/download/).

#### Font

Install [JetBrains mono](https://www.jetbrains.com/lp/mono/#how-to-install).

#### VS Code

1. Install [VS Code](https://code.visualstudio.com/).
2. Turn on sync.

#### [MacOS] Navigation

1. Install [Raycast](https://www.raycast.com/).
2. Disable hotkey for Spotlight.