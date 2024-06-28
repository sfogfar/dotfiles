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
    },
  },

  -- help with keybinds
  { "folke/which-key.nvim", opts = {} },

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {}
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "tokyonight",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -- fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
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

  -- close parens
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  -- commenting
  { "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines

  -- language specific support
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python" },
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
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }
  -- {
  --   "scalameta/nvim-metals",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     {
  --       "j-hui/fidget.nvim",
  --       opts = {},
  --     }
  --   },
  --   ft = { "scala", "sbt", "java" },
  --   opts = function()
  --     local metals_config = require("metals").bare_config()

  --     -- Example of settings
  --     metals_config.settings = {
  --       showImplicitArguments = true,
  --       excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  --     }

  --     -- Let fidget.nvim handle the status updates.
  --     metals_config.init_options.statusBarProvider = "off"

  --     metals_config.on_attach = function(_, _)
  --     local map = vim.keymap.set

  --     --   -- LSP mappings
  --     --   map("n", "gD", vim.lsp.buf.definition)
  --     map("n", "K", vim.lsp.buf.hover)
  --     --   map("n", "gi", vim.lsp.buf.implementation)
  --     --   map("n", "gr", vim.lsp.buf.references)
  --     --   map("n", "gds", vim.lsp.buf.document_symbol)
  --     --   map("n", "gws", vim.lsp.buf.workspace_symbol)
  --     --   map("n", "<leader>cl", vim.lsp.codelens.run)
  --     --   map("n", "<leader>sh", vim.lsp.buf.signature_help)
  --     --   map("n", "<leader>rn", vim.lsp.buf.rename)
  --     --   map("n", "<leader>f", vim.lsp.buf.format)
  --     --   map("n", "<leader>ca", vim.lsp.buf.code_action)

  --     --   map("n", "<leader>ws", function()
  --     --     require("metals").hover_worksheet()
  --     --   end)

  --     --   -- all workspace diagnostics
  --     --   map("n", "<leader>aa", vim.diagnostic.setqflist)

  --     --   -- all workspace errors
  --     --   map("n", "<leader>ae", function()
  --     --     vim.diagnostic.setqflist({ severity = "E" })
  --     --   end)

  --     --   -- all workspace warnings
  --     --   map("n", "<leader>aw", function()
  --     --     vim.diagnostic.setqflist({ severity = "W" })
  --     --   end)

  --     --   -- buffer diagnostics only
  --     --   map("n", "<leader>d", vim.diagnostic.setloclist)

  --     --   map("n", "[c", function()
  --     --     vim.diagnostic.goto_prev({ wrap = false })
  --     --   end)

  --     --   map("n", "]c", function()
  --     --     vim.diagnostic.goto_next({ wrap = false })
  --     --   end)
  --     end

  --     return metals_config
  --   end,
  --   config = function(self, metals_config)
  --     local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = self.ft,
  --       callback = function()
  --         require("metals").initialize_or_attach(metals_config)
  --       end,
  --       group = nvim_metals_group,
  --     })
  --   end
  -- }
}, {})
