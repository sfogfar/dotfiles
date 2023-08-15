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
  x -> visual

--]]

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


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

Official documentation: -- TODO: add links

--]]

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}


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

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<CR>", opts)
keymap("n", "<leader>faf", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<CR>", opts) -- find current word
keymap("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)
keymap("n", "<leader>fib", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", opts) -- TODO: try having this as a dropdown instead
keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<CR>", opts)

--[[
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
-]]

-- }}}

-- new section template {{{

--[[

Official documentation: <url>

Relevant notes: <foo is bar, bar is baz...>

--]]

-- }}}
