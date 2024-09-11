-- vim:foldmethod=marker

-- pre-requisites {{{

--[[

This section contains anything that should always be run before the main configuration steps.

--]]

-- workaround for nvim being unable to find volta managed node packages
vim.cmd [[
  if executable("volta")
    let g:node_host_prog = trim(system("volta which neovim-node-host"))
  endif
]]

-- function shorthands
local keymap = vim.api.nvim_set_keymap

-- }}}

-- options {{{
--[[

Official documentation: https://neovim.io/doc/user/options.html

--]]

-- appearance
vim.opt.showtabline = 2
vim.opt.showmatch = true
vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.cursorline = false
vim.opt.cmdheight = 2
vim.opt.pumheight = 10
vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd [[
  :augroup numbertoggle
  :  autocmd!
  :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  :augroup END
]]

-- indentation
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.conceallevel = 0
vim.opt.shortmess:append "a"

-- navigation
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.iskeyword:append "-"
vim.opt.completeopt = { "menuone", "noselect" }

-- search
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- system behaviours
vim.opt.mouse = a
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 300
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = true

-- }}}

-- keymaps {{{
--[[

Official documentation: https://neovim.io/doc/user/api.html#nvim_set_keymap()

Modes key:
  n -> normal
  i -> insert
  v -> visual
  x -> visual block

--]]

local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","


-- normal {{{

-- quick write and quit
keymap("n", "<leader>w", ":wa<CR>", opts) -- TODO: consider alternative commands
keymap("n", "<leader>q", ":wqa<CR>", opts)

-- better window navigation
-- keymap("n", "<leader>o", ":on<CR>", opts) -- TODO: never use this, OK to remove?
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize with arrows
-- TODO: resolve conflicts with MacOS workspace navigation
-- keymap("n", "<C-Down>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Up>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)

-- navigate buffers
keymap("n", "<left>", ":bnext<CR>", opts)
keymap("n", "<right>", ":bprevious<CR>", opts)

-- move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)

-- }}}

-- insert {{{

-- kj to escape
keymap("i", "kj", "<ESC>", opts)

-- }}}

-- visual {{{

-- stay in indent mode
keymap("v", "<", "<gv", opts) -- TODO: review behaviour
keymap("v", ">", ">gv", opts) -- TODO: review behaviour

-- move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- }}}

-- visual block {{{

-- move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- }}}

-- }}}

-- commands {{{

--[[

Official documentation: https://neovim.io/doc/user/api.html#nvim_create_user_command()

--]]

local command = vim.api.nvim_create_user_command

-- Clear highlighting
command("C", "let @/=''", {})

-- }}}

-- plugins {{{

--[[

Official documentation: https://github.com/wbthomason/packer.nvim#packernvim

Using packer to manage plugins.
Packer config is isolated so it will only be auto loaded anytime it is updated.

--]]

require "sam.plugins"

-- }}}

-- colorscheme {{{

vim.cmd [[colorscheme tokyonight-storm]]
-- vim.cmd[[colorscheme tokyonight-day]]

-- }}}

-- lsp and completion {{{

--[[

Official documentation: -- TODO: add links

--]]

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("ga", vim.lsp.buf.code_action, "[G]oto [A]ctions")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- format
  nmap("<leader>fmt", vim.lsp.buf.format, "[F]or[m]a[t]")
end

local servers = {
  tsserver = {},
  eslint = {},
  clojure_lsp = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

local cmp = require "cmp"
local luasnip = require "luasnip"
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete {},
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    -- useful for nvim config
    { name = "nvim_lua" },
    { name = "luasnip" },
    -- standard completion
    { name = "nvim_lsp" },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'treesitter' },
    -- prose writing
    {
      name = 'dictionary',
      keyword_length = 2,
    }
  },
}

require("cmp_dictionary").setup({
 dic = {
   ["*"] = { "/usr/share/dict/words" },
 },
})

-- }}}

-- treesitter {{{

--[[

Official documentation: https://github.com/nvim-treesitter/nvim-treesitter#nvim-treesitter

--]]

local treesitter_status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_status_ok then
  vim.notify("Unable to load treesitter.")
  return
end

treesitter_configs.setup({
  ensure_installed = {
    "css",
    "fish",
    "haskell",
    "html",
    "javascript",
    "json",
    "lua",
    "tsx",
    "typescript",
    "scala",
    "clojure",
    "go"
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    disable = {},
    extended_mode = true,
    max_file_lines = nil,
  }
})

-- }}}

-- telescope {{{

--[[

Official documentation: https://github.com/nvim-telescope/telescope.nvim#telescopenvim

--]]

require("telescope").load_extension("fzf")

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<CR>", opts)
keymap("n", "<leader>faf", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<CR>", opts)
keymap("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)
keymap("n", "<leader>fib", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", opts) -- TODO: try having this as a dropdown instead
keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<CR>", opts)

-- }}}

-- metals {{{

--[[

Official documentation: https://github.com/scalameta/nvim-metals/discussions/39

Relevant notes: <foo is bar, bar is baz...>

--]]

local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
-- }}}

-- prose writing {{{

--[[

Official documentation: <url>

Relevant notes: <foo is bar, bar is baz...>

--]]

local M = {}

function M.setup_prose_mode()
  vim.wo.wrap = true
  vim.wo.linebreak = true
  vim.wo.breakindent = true

  vim.bo.textwidth = 80

  vim.wo.spell = true
  vim.bo.spelllang = "en_gb"

  vim.opt_local.formatoptions:append {
    t = true,  -- Auto-wrap text using textwidth
    n = true,  -- Recognize numbered lists
    ['1'] = true,  -- Don't break a line after a one-letter word
  }

  vim.bo.softtabstop = 2
  vim.bo.shiftwidth = 2

  -- Map j and k to gj and gk (move by visual lines)
  vim.keymap.set("n", "j", "gj", { buffer = true })
  vim.keymap.set("n", "k", "gk", { buffer = true })

  -- Set up autocommands for auto-wrapping in insert mode
  local group = vim.api.nvim_create_augroup("ProseAutoWrap", { clear = true })
  vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    buffer = 0,
    callback = function()
      vim.opt_local.formatoptions:append { a = true }  -- Auto-format in insert mode
    end,
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    buffer = 0,
    callback = function()
      vim.opt_local.formatoptions:remove { a = true }  -- Disable auto-format when leaving insert mode
    end,
  })

  -- Add keybinding for manual reformatting
  vim.keymap.set("n", "<leader>fmt", "gqip", { buffer = true, desc = "Reformat paragraph" })
  vim.keymap.set("v", "<leader>fmt", "gq", { buffer = true, desc = "Reformat selection" })

  print("Prose mode activated")
end

-- Set up autocommands to activate prose mode for certain filetypes
local prose_group = vim.api.nvim_create_augroup("ProseMode", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = prose_group,
  pattern = { "markdown", "text" },
  callback = M.setup_prose_mode,
})

-- Optionally, add a command to manually toggle pro

-- }}}

-- new section template {{{

--[[

Official documentation: <url>

Relevant notes: <foo is bar, bar is baz...>

--]]

-- }}}
