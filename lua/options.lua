vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.mouse = "a"

vim.o.swapfile = false

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Relative Line Numbers
vim.o.nu = true
vim.o.rnu = true

-- Enable break indent
vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = " ", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.opt.winborder = "double"

--wezterm redraw fix (may not be needed)
-- vim.opt.termsync = false

-- Stops redraw using macros
vim.o.lazyredraw = false

-- Disabled commenting on new line
vim.cmd("autocmd BufEnter * set formatoptions-=cro")

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Allow me to use dd in quickfixlist
vim.o.ma = true

vim.o.colorcolumn = "80"
vim.o.splitright = true
vim.o.splitbelow = true

vim.wo.signcolumn = "yes"

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- config for UFO and statuscol
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
