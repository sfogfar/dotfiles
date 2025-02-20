# Keybindings {{{
# Use vim keybindings
bindkey -v

# Edit longer commands in neovim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# }}}

# fzf {{{

# Added by fzf install script
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# }}}

# Aliases {{{
# Neovim for lazy typists
if [[ -n "$(command -v nvim)" ]]; then
    alias vi="nvim"
    alias vim="nvim"
fi

# File system
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Navigation
alias g='git'
alias rps='cd ~/repos'
alias dots='cd ~/dotfiles'

# Quick edits
alias zshconfig="$EDITOR ~/.zshrc"
alias nviminit="$EDITOR ~/nvim/init.lua"
alias reload="source ~/.zshrc"
# }}}

# Completion {{{
# Use modern completion system
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Fish-like autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# }}}

# History {{{
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY             # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate.

setopt COMPLETE_ALIASES
# }}}

# Options {{{
# Automatically cd into typed directory
setopt autocd

# Disable ctrl-s and ctrl-q
setopt noflowcontrol
# }}}

# Environment Variables {{{
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# }}}

# Prompt {{{
eval "$(starship init zsh)"
# }}}

# vim:foldmethod=marker:foldlevel=0

# pnpm
export PNPM_HOME="/Users/samcooper/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
