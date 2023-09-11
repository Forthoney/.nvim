-- [[ Setting options ]]
-- See `:help vim.opt`
-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = ""

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 50

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- Set colorscheme
vim.opt.termguicolors = true
vim.cmd([[colorscheme rose-pine]])

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

vim.g.python3_host_prog = "/home/castlehoney/mambaforge/envs/neovim/bin/python"
