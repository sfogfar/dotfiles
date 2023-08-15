-- vim:foldmethod=marker

-- pre-requisites {{{

--[[

This section contains anything that should always be run before the main configuration steps.

--]]

-- workaround for nvim being unable to find volta managed node packages
vim.cmd [[
  if executable('volta')
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
vim.opt.cursorline = false -- TODO: review preference
vim.opt.cmdheight = 2
vim.opt.pumheight = 10
vim.opt.numberwidth = 2 -- TODO: review preference
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
vim.opt.shortmess:append "a" -- TODO: review preference

-- navigation
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.iskeyword:append "-" -- TODO: review preference
vim.opt.completeopt = { "menuone", "noselect" }

-- search
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- system behaviours
vim.opt.mouse = a -- TODO: review behaviour
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 300
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = false

-- }}}

-- keymaps {{{
--[[

Official documentation: https://neovim.io/doc/user/api.html#nvim_set_keymap()

Modes key:
  n -> normal
  i -> insert
  v -> visual
  x -> visual

--]]

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- normal {{{

-- quick write and quit
keymap("n", "<leader>w", ":wa<CR>", opts)
keymap("n", "<leader>q", ":wqa<CR>", opts)

-- better window navigation
keymap("n", "<leader>o", ":on<CR>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize with arrows
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts) -- TODO: Resolve conflict with MacOS workspace nav shortcut
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts) -- TODO: Resolve conflict with MacOS workspace nav shortcut

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
-- keymap("v", "p", '"_dP', opts)                               -- TODO: review behaviour

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
command('C', 'let @/=""', {})

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

local colorscheme = "dracula"
local colorscheme_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_status_ok then
  vim.notify("Unable to load " .. colorscheme .. " colorscheme.")
  return
end


-- }}}

-- lsp {{{

--[[

(un)Official documentation: https://github.com/VonHeikemen/lsp-zero.nvim

--]]

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

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
    "clojure"
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

require("telescope").load_extension('fzf')

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)
keymap("n", "<leader>fib", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", opts)
keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<CR>", opts)

--[[
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
-]]

-- }}}

-- lualine {{{

--[[

Official documentation: https://github.com/nvim-lualine/lualine.nvim#lualinenvim

--]]
require('lualine').setup {
  options = { theme = require("lualine.themes.dracula") },
  ...
}

-- }}}

-- new section template {{{

--[[

Official documentation: <url>

Relevant notes: <foo is bar, bar is baz...>

--]]

-- }}}
