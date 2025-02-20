-- Install package manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
      "uga-rosa/cmp-dictionary"
    },
  },

  -- help with keybinds
  {
    "folke/which-key.nvim",
    opts = {}
  },

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {}
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "catppuccin",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -- fuzzy finding
  {
    "ibhagwan/fzf-lua",
    dependencies = {},
    opts = {}
  },

  -- file management
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },

  -- formatting
  { "mhartington/formatter.nvim" },

  -- editing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  {
    "PaterJason/nvim-treesitter-sexp",
    dependencies = {},
    opts = {}
  },

  -- commenting
  { "numToStr/Comment.nvim",     opts = {} }, -- "gc" to comment visual regions/lines

  -- git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      "nvim-telescope/telescope.nvim",
    },
    config = true
  },

  -- language specific support
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "scheme" },
    dependencies = {
      {
        "PaterJason/cmp-conjure",
        config = function()
          local cmp = require("cmp")
          local config = cmp.get_config()
          table.insert(config.sources, {
            name = "buffer",
            option = {
              sources = {
                { name = "conjure" },
              },
            },
          })
          cmp.setup(config)
        end,
      },
    },
    config = function(_, _)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      vim.g["conjure#debug"] = false
    end,
  },

  {
    "clojure-vim/vim-jack-in",
    lazy = true,
    ft = { "clojure" },
    dependencies = {
      "tpope/vim-dispatch",
      "radenling/vim-dispatch-neovim",
    }
  },

  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    dependencies = { "nvim-lua/plenary.nvim" }
  }
}, {})
