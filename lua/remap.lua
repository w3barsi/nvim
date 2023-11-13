vim.keymap.set('n', 'gf', vim.lsp.buf.format)
-- [[ Basic Keymaps ]]
vim.keymap.set('n', ';;', 'A;<Esc>')

-- Opens :Explorer
vim.keymap.set('n', '<C-e>', '<cmd>Explore <CR>')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<ieader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<C-f>', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Move Text in Visual Block Up or Down
vim.keymap.set('n', '<A-k>', [[V:m '<-2<CR>gv=]], { silent = true })
vim.keymap.set('n', '<A-j>', [[V:m '>+1<CR>gv=]], { silent = true })
vim.keymap.set('v', '<A-k>', [[:m '<-2<CR>gv=gv]], { silent = true })
vim.keymap.set('v', '<A-j>', [[:m '>+1<CR>gv=gv]], { silent = true })
vim.keymap.set('i', '<A-k>', [[<esc>:m .-2<CR>==a]], { silent = true })
vim.keymap.set('i', '<A-j>', [[<esc>:m .+1<CR>==a]], { silent = true })

-- Re-highlights lines after indenting
vim.keymap.set('v', '>', '>gv', { silent = true })
vim.keymap.set('v', '<', '<gv', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>h', '<cmd>wincmd h <CR>')
vim.keymap.set('n', '<leader>j', '<cmd>wincmd j <CR>')
vim.keymap.set('n', '<leader>k', '<cmd>wincmd k <CR>')
vim.keymap.set('n', '<leader>l', '<cmd>wincmd l <CR>')
vim.keymap.set('n', '<A-h>', '<cmd>wincmd h <CR>')
vim.keymap.set('n', '<A-l>', '<cmd>wincmd l <CR>')

-- Ctrl + BS Erases a word
-- Using vim.cmd for now
vim.cmd [[noremap! <C-BS> <C-w>]]
vim.cmd [[noremap! <C-h> <C-w>]]
-- Makes it so x doesn't touch buffer
vim.keymap.set('n', 'x', [["_x]])

-- Centers C-d and C-u
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('n', '{', '{zz', opts)
vim.keymap.set('n', '}', '}zz', opts)
vim.keymap.set('n', 'G', 'Gzz', opts)
vim.keymap.set('n', 'gg', 'ggzz', opts)
vim.keymap.set('n', '<C-o>', '<C-o>zz', opts)
vim.keymap.set('n', '<C-i>', '<C-i>zz', opts)
vim.keymap.set('n', 'N', 'Nzz', opts)
vim.keymap.set('n', 'n', 'nzz', opts)

-- Paste without changing clipboard buffer
vim.keymap.set('x', '<leader>p', '"_dP', { silent = true })

vim.keymap.set('n', '<leader><leader>', '<cmd>w! <CR>')

-- Folding Remaps

vim.keymap.set('n', '<leader>]', '<cmd>foldclose<CR>', { desc = 'Close Folds' })
vim.keymap.set('n', '<leader>[', '<cmd>foldopen<CR>', { desc = 'Open Folds' })
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
