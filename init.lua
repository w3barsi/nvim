vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- require('kickstart.plugins.autoformat'),
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- require nvim options
require 'autocmd'
require 'options'
require 'remap'

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

require 'custom.lsp'
require 'custom.cmp'

local function override_groups(groups, overrides)
  for group, setting in pairs(overrides) do
    groups[group] = setting
  end
end
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
