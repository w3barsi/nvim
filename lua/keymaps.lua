local opts = { noremap = true, silent = true }

local opts = { noremap = true, silent = true }
local harpoon = require("harpoon")
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

vim.keymap.set("n", "]]", "<C-]>", { noremap = true, silent = true, desc = "Go to first Definition" })

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

vim.keymap.set("n", "]d", function()
    local ok = pcall(vim.diagnostic.jump, { count = 1, float = false })
    if ok then
        vim.api.nvim_feedkeys("zz", "n", false)
    end
end, { desc = "[LSP] Go to next diagnostic and center" })

vim.keymap.set("n", "[d", function()
    local ok = pcall(vim.diagnostic.jump, { count = -1, float = false })
    if ok then
        vim.api.nvim_feedkeys("zz", "n", false)
    end
end, { desc = "[LSP] Go to previous diagnostic and center" })

vim.keymap.set("n", "]e", function()
    local ok = pcall(vim.diagnostic.jump, { count = 1, severity = vim.diagnostic.severity.ERROR, float = false })
    if ok then
        vim.api.nvim_feedkeys("zz", "n", false)
    end
end, { desc = "[LSP] Go to next error diagnostic and center" })

vim.keymap.set("n", "[e", function()
    local ok = pcall(vim.diagnostic.jump, { count = -1, severity = vim.diagnostic.severity.ERROR, float = false })
    if ok then
        vim.api.nvim_feedkeys("zz", "n", false)
    end
end, { desc = "[LSP] Go to previous error diagnostic and center" })

vim.keymap.set("n", "]w", function()
    local ok = pcall(vim.diagnostic.jump, { count = 1, severity = vim.diagnostic.severity.WARN, float = false })
    if ok then
        vim.api.nvim_feedkeys("zz", "n", false)
    end
end, { desc = "[LSP] Go to next warning diagnostic and center" })

vim.keymap.set("n", "[w", function()
    local ok = pcall(vim.diagnostic.jump, { count = -1, severity = vim.diagnostic.severity.WARN, float = false })
    if ok then
        vim.api.nvim_feedkeys("zz", "n", false)
    end
end, { desc = "[LSP] Go to previous warning diagnostic and center" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float({ border = "double" })
end, { desc = "Open diagnostic float with rounded border" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

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

-- Returns to last selected letter on visual mode yank
vim.keymap.set("v", "y", "ygv<Esc>")

local function open_env_file()
    local bufname = vim.fn.fnamemodify(vim.fn.bufname(), ":t")
    if bufname == ".env" or bufname == ".env.local" then
        vim.cmd("normal! <C-o>")
    elseif vim.fn.filereadable(".env") == 1 then
        vim.cmd("e .env")
    elseif vim.fn.filereadable(".env.local") == 1 then
        vim.cmd("e .env.local")
    else
        vim.notify("env does not exist", vim.log.levels.WARN)
    end
end

vim.keymap.set("n", "``", open_env_file, { desc = "Open .env file" })

-- Quickfix List Remaps
vim.keymap.set("n", "qo", ":copen<CR>", { desc = "[Q]uickfix list [O]pen", silent = true })
vim.keymap.set("n", "qq", ":cclose<CR>", { desc = "[Q]uickfix list [Q]uit", silent = true })
vim.keymap.set(
    "n",
    "qc",
    ":cexpr []<CR>:cclose<CR>:echo 'Quickfix List Cleared'<CR>",
    { desc = "[Q]uickfix list [C]lear then close", silent = true }
)
vim.keymap.set("n", "]q", ":cnext<CR>zz", { desc = "Quickfix list next", silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>zz", { desc = "Quickfix list prev", silent = true })

vim.keymap.set("n", "<leader>t", ":UndotreeToggle<CR>", { desc = "Toggle Undotree", silent = true })
vim.keymap.set("n", "<leader>lr", ":lsp restart<CR>", { desc = "Restarting LSP Server", silent = true })

-- vim.keymap.set({ "n", "x", "o" }, "<enter>", function()
--     if vim.treesitter.get_parser(nil, nil, { error = false }) then
--         require("vim.treesitter._select").select_parent(vim.v.count1)
--     else
--         vim.lsp.buf.selection_range(vim.v.count1)
--     end
-- end, { desc = "Select parent treesitter node or outer incremental lsp selections" })
--
-- vim.keymap.set({ "n", "x", "o" }, "<bs>", function()
--     if vim.treesitter.get_parser(nil, nil, { error = false }) then
--         require("vim.treesitter._select").select_child(vim.v.count1)
--     else
--         vim.lsp.buf.selection_range(-vim.v.count1)
--     end
-- end, { desc = "Select child treesitter node or inner incremental lsp selections" })

vim.keymap.set("n", "\\", "<cmd>w<cr>")

-- Neocodeium keymaps

vim.keymap.set("i", "<C-\\>", require("neocodeium").accept)
vim.keymap.set("i", "<A-[>", function()
    require("neocodeium").cycle(-1)
end)
vim.keymap.set("i", "<A-]>", function()
    require("neocodeium").cycle(1)
end)
