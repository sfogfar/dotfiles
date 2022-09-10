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

return packer.startup({function(use)
  use "wbthomason/packer.nvim"

  -- colorscheme
  use {'dracula/vim', as = 'dracula'}

  -- completion
  use {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  }

  -- lsp
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  --[[
  fairly sure popup is deprecated, plenary is unneeded
  wait and see, plenary may be a dependency of telescope...

  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  --]]
  
end,
config = {
  display = {
    open_fn = require("packer.util").float,
  },
}})

