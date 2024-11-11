# dotfiles

My version controlled dotfiles.

## Note on approach

It is preferable to keep this repo simple, with portable dotfiles that can
easily be cloned and used to configure essential tooling on any machine, than to
have this be heavily automated but temperamental.

As such, this repo will ideally contain only files that are:

1. Manually written (i.e.: not the consequence of installing some plugin).
2. Fairly universal.

These files should be symlinked to where they are needed to take effect. In most
cases it is not necessary to symlink the entire contents of `.config` or even
sub-directories of it and I will prefer to only link the subsets of that
directory that I have interacted with most manually.

It may sometimes be more appropriate to make notes here on how to configure
something, than to try and store the config itself. For example, VSCode
extensions and settings.json are more easily managed by syncing than by using
this repo.

## TODOs

- Add descriptions to remaps / register with which-key.
- Bring final vimscript functions across to Lua.
- Add i3 setup instructions for Linux.
- Try and get gui MacOS settings defined in config files.

## Setting up a system from scratch

### [macOS] Homebrew

1. Install [Homebrew](https://brew.sh/).

### Git

1. `sudo apt install git` || `brew install git`
2. [Connect to GitHub with
SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
3. `ln -s ~/dotfiles/git/gitconfig ~/.gitconfig`
4. `ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global`

### Neovim

1. Install
   [Neovim](https://github.com/neovim/neovim?tab=readme-ov-file#install-from-package).
2. Run `nvim +checkhealth`, making sure to check python and node providers.
3. `ln -s ~/dotfiles/nvim/ ~/.config/nvim`

_Note:_ Resolved compilation error when installing nvim-treesitter on Linux Mint
by running `sudo apt install g++`.

### Kitty

1. Install [Kitty](https://sw.kovidgoyal.net/kitty/) 
2. [Linux only] Add to desktop.
3. `ln -s ~/dotfiles/kitty/ ~/.config/kitty`

### ZSH

1. `ln -s ~/dotfiles/zsh/.zshenv ~/.zshenv`
2. `ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc`
3. `ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml`

### Fish

1. Install [Fish](https://fishshell.com/).
2. [macOS only] Using zsh: `echo $path`, then using fish: `fish_add_path ...`
   for each relevant.
3. `ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish`
4. `ln -s ~/dotfiles/fish/functions/ ~/.config/fish/functions`

### Command line comforts

1. Install [Starship](https://starship.rs/).
2. `ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml`
3. Install [fzf](https://github.com/junegunn/fzf#using-git). Note: Disable
conflicting window management command for launch in Raycast / Window Management.
3. [Fish only] Install
   [fzf.fish](https://github.com/PatrickF1/fzf.fish#installation).

#### MacOS
4. `brew install ripgrep fd bat tree`

#### Linux
4. Install [ripgrep](https://github.com/BurntSushi/ripgrep#installation).
5. Install [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation).
6. Install
   [bat](https://github.com/sharkdp/bat?tab=readme-ov-file#installation).

### Browser

Anything with the [Bitwarden](https://bitwarden.com/) extension.

### Font

[JetBrains mono](https://github.com/JetBrains/JetBrainsMono#brew-macos-only).

### VS Code 

Useful for markdown previews and git conflict resolution.

1. Install [VS Code](https://code.visualstudio.com/).
2. Turn on sync.

### MacOS system settings

##### Navigation

1. Install [Raycast](https://www.raycast.com/) and disable hot key for
   Spotlight.
2. Enable touch to click.

##### Screenshots

1. `mkdir ~/Pictures/screenshots`
2. `defaults write com.apple.screencapture location ~/Pictures/screenshots`
