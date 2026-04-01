-- treat .env.local as shell script
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = ".env.*",
    callback = function()
        vim.bo.filetype = "sh"
    end,
})
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 250 })
    end,
    group = highlight_group,
    pattern = "*",
})

vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})
-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})
