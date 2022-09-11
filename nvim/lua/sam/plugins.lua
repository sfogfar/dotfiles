-- run PackerSync any time this file is updated
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  vim.notify("Unable to load packer.")
  return
end

return packer.startup({function()
  use "wbthomason/packer.nvim"

  -- colorscheme
  use {'dracula/vim', as = 'dracula'}

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- syntax highlighting
  use {"neoclide/coc.nvim", branch = "release"}

  -- syntax highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- fuzzy finding
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = { {"nvim-lua/plenary.nvim"} }
  }

  -- close parens
  use {"raimondi/delimitmate"}
 
end,
config = {
  display = {
    open_fn = require("packer.util").float,
  },
}})

