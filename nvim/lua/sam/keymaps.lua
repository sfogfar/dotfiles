-- https://neovim.io/doc/user/api.html#nvim_set_keymap() 

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Quick write and quit
keymap("n", "<leader>w", ":wa<CR>", opts)
keymap("n", "<leader>q", ":wqa<CR>", opts)

-- Better window navigation
keymap("n", "<leader>o", ":on<CR>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)        -- TODO: Resolve conflict with MacOS workspace nav shortcut
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)       -- TODO: Resolve conflict with MacOS workspace nav shortcut

-- Navigate buffers
keymap("n", "<left>", ":bnext<CR>", opts)
keymap("n", "<right>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)

-- Insert --
-- Press kj fast to exit insert mode 
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)                                   -- TODO: review behaviour
keymap("v", ">", ">gv", opts)                                   -- TODO: review behaviour

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)                               -- TODO: review behaviour 

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

