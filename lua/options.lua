-- vim.o.guicursor = ""
-- Set highlight on search
vim.o.hlsearch = false

-- Relative Line Numbers
vim.o.nu = false
vim.o.rnu = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true

vim.o.colorcolumn = "80"

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.swapfile = false

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Highlights current line
vim.o.cursorline = true

-- Stops redraw using macros
vim.o.lazyredraw = false

-- Set completion menu height
vim.o.pumheight = 10

-- Disabled commenting on new line
vim.cmd("autocmd BufEnter * set formatoptions-=cro")

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Allow me to use dd in quickfixlist
vim.o.ma = true
