set -g fish_greeting
starship init fish | source

set fzf_fd_opts --hidden --exclude=.git

fish_vi_key_bindings
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
