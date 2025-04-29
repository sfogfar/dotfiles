if status is-interactive
  set -g fish_greeting
  set fzf_fd_opts --hidden --exclude=.git
  fish_vi_key_bindings
  fzf_configure_bindings
  starship init fish | source
end
