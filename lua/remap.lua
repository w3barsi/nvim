local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader><Tab>", ":Inspect<cr>", opts)
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "]]", "<C-]>", { noremap = true, silent = true, desc = "Go to first Definition" })
--
-- [[ Basic Keymaps ]]
vim.keymap.set("n", ";;", "A;<Esc>")

-- Opens :Explorer
-- vim.keymap.set('n', '<C-e>', '<cmd>Explore <CR>')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set("n", "/", function()
--     -- You can pass additional configuration to telescope to change theme, layout, etc.
--     require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
--         winblend = 10,
--         previewer = false,
--     }))
-- end, { desc = "[/] Fuzzily search in current buffer" })

-- Move Text in Visual Block Up or Down
vim.keymap.set("n", "<A-k>", [[V:m '<-2<CR>gv=]], { silent = true })
vim.keymap.set("n", "<A-j>", [[V:m '>+1<CR>gv=]], { silent = true })
vim.keymap.set("v", "<A-k>", [[:m '<-2<CR>gv=gv]], { silent = true })
vim.keymap.set("v", "<A-j>", [[:m '>+1<CR>gv=gv]], { silent = true })
vim.keymap.set("i", "<A-k>", [[<esc>:m .-2<CR>==a]], { silent = true })
vim.keymap.set("i", "<A-j>", [[<esc>:m .+1<CR>==a]], { silent = true })

-- Re-highlights lines after indenting
vim.keymap.set("v", ">", ">gv", { silent = true })
vim.keymap.set("v", "<", "<gv", { silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Split view management
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h <CR>")
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j <CR>")
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k <CR>")
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l <CR>")
vim.keymap.set("n", "<A-h>", "<cmd>wincmd h <CR>")
vim.keymap.set("n", "<A-l>", "<cmd>wincmd l <CR>")

-- Makes it so x doesn't touch buffer
vim.keymap.set("n", "x", [["_x]])

-- Centers motion keymaps
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "{", "{zz", opts)
vim.keymap.set("n", "}", "}zz", opts)
vim.keymap.set("n", "G", "Gzz", opts)
vim.keymap.set("n", "gg", "ggzz", opts)
vim.keymap.set("n", "<C-o>", "<C-o>zz", opts)
-- vim.keymap.set("n", "<C-i>", "<C-i>zz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "n", "nzz", opts)

-- Paste without changing clipboard buffer
vim.keymap.set("x", "<leader>p", '"_dP', { silent = true })

-- vim.keymap.set("n", "<tab>", "<cmd>w! <CR>")

-- Folding Remaps

vim.keymap.set("n", "<leader>]", "<cmd>foldclose<CR>", { desc = "Close Folds" })
vim.keymap.set("n", "<leader>[", "<cmd>foldopen<CR>", { desc = "Open Folds" })
-- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

vim.keymap.set("n", "<leader>lg", ":lua Snacks.lazygit()", { silent = true })
vim.keymap.set("n", "=", ":lua Snacks.lazygit()<CR>", { silent = true })

-- Returns to last selected letter on visual mode yank
vim.keymap.set("v", "y", "ygv<Esc>")
-- vim.keymap.set("n", "V", "v$", opts)
-- vim.keymap.set("n", "vv", "V", opts)

local harpoon = require("harpoon")
local extensions = require("harpoon.extensions")
-- Harpoon Keymaps
vim.keymap.set("n", ",a", function()
    harpoon:list():add()
end, { desc = "Add to harpoon buffer" })
vim.keymap.set("n", ",p", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open Harpoon Quick Menu" })

vim.keymap.set("n", ",q", function()
    harpoon:list():select(1)
end, { desc = "Harpoon Buffer 1" })
vim.keymap.set("n", ",w", function()
    harpoon:list():select(2)
end, { desc = "Harpoon Buffer 2" })
vim.keymap.set("n", ",e", function()
    harpoon:list():select(3)
end, { desc = "Harpoon Buffer 3" })
vim.keymap.set("n", ",r", function()
    harpoon:list():select(4)
end, { desc = "Harpoon Buffer 4" })

local function open_env_file()
    if vim.fn.filereadable('.env') == 1 then
        vim.cmd('e .env')
    elseif vim.fn.filereadable('.env.local') == 1 then
        vim.cmd('e .env.local')
    else
        vim.notify('env does not exist', vim.log.levels.WARN)
    end
end

vim.keymap.set("n", "``", open_env_file, { desc = "Open .env file" })

-- -- Open Oil to components dir
vim.keymap.set(
    "n",
    ",c",
    [[:Oil src/app/_components<CR>]],
    { desc = "Open Oil to components directory", silent = true }
)

-- Closes all buffers
vim.keymap.set("n", "<leader>bd", [[:w | %bd | e# | bd#<CR> | '"zz]], { desc = "[B]uffer [D]elete", silent = true })

-- Quickfix List Remaps
vim.keymap.set("n", "qo", ":copen<CR>", { desc = "[Q]uickfix list [O]pen", silent = true })
vim.keymap.set("n", "qq", ":cclose<CR>", { desc = "[Q]uickfix list [Q]uit", silent = true })
vim.keymap.set(
    "n",
    "qc",
    ":cexpr []<CR>:cclose<CR>:echo 'Quickfix List Cleared'<CR>",
    { desc = "[Q]uickfix list [C]lear then close", silent = true }
)
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Quickfix list next", silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Quickfix list prev", silent = true })

vim.keymap.set("n", "<leader>t", ":UndotreeToggle<CR>", { desc = "Toggle Undotree", silent = true })
