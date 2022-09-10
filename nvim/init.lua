-- vim:foldmethod=marker

-- TODO: add readme / usage guide here

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

-- }}}

-- commands {{{

--[[ 

Official documentation: https://neovim.io/doc/user/api.html#nvim_create_user_command()

--]]

local command = vim.api.nvim_create_user_command

-- Clear highlighting
command('C', 'let @/=""', {})

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

local keymap = vim.api.nvim_set_keymap
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
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)        -- TODO: Resolve conflict with MacOS workspace nav shortcut
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)       -- TODO: Resolve conflict with MacOS workspace nav shortcut

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
keymap("v", "<", "<gv", opts)                                   -- TODO: review behaviour
keymap("v", ">", ">gv", opts)                                   -- TODO: review behaviour

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

-- options {{{
--[[

Official documentation: https://neovim.io/doc/user/options.html

--]]

-- appearance
vim.opt.showtabline = 2
vim.opt.showmatch = true
vim.opt.wrap = false
vim.opt.showmode = true                -- TODO: review necessity
vim.opt.cursorline = false             -- TODO: review preference
vim.opt.cmdheight = 2
vim.opt.pumheight = 10
vim.opt.numberwidth = 2                -- TODO: review preference
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = false          -- TODO: enable

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
vim.opt.shortmess:append "a"           -- TODO: review preference

-- navigation
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.iskeyword:append "-"           -- TODO: review preference

-- search
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- system behaviours
vim.opt.mouse = a                      -- TODO: review behaviour
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 300
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = false

-- }}}

-- new section template {{{

--[[

Official documentation: <url>

Relevant notes: <foo is bar, bar is baz...>

--]]

-- }}}

