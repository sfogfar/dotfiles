-- https://neovim.io/doc/user/api.html#nvim_create_user_command()

local command = vim.api.nvim_create_user_command

command('C', 'let @/=""', {})

