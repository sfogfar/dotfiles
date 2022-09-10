-- workaround for nvim being unable to find volta managed node packages
vim.cmd [[
  if executable('volta')
    let g:node_host_prog = trim(system("volta which neovim-node-host"))
  endif
]]

require "sam.options"
require "sam.keymaps"
require "sam.commands"
