-- https://neovim.io/doc/user/options.html

-- appearance
vim.opt.number = true
vim.opt.relativenumber = true
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

-- indentation
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.conceallevel = 0
vim.opt.shortmess:append "a"           -- TODO: review preference

-- search
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- navigation
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.iskeyword:append "-"           -- TODO: review preference

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
