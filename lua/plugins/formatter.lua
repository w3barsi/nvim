-- return {
--   'mhartington/formatter.nvim',
--   config = function()
--     -- Utilities for creating configurations
--     local util = require 'formatter.util'
--
--     -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
--     require('formatter').setup {
--       -- Enable or disable logging
--       logging = true,
--       -- Set the log level
--       log_level = vim.log.levels.WARN,
--       -- All formatter configurations are opt-in
--       filetype = {
--         -- Formatter configurations for filetype "lua" go here
--         -- and will be executed in order
--         lua = {
--           -- "formatter.filetypes.lua" defines default configurations for the
-- return {
--     "jose-elias-alvarez/null-ls.nvim",
--     config = function()
--         local null_ls = require("null-ls")
--
--         null_ls.setup({
--             sources = {
--                 null_ls.builtins.formatting.stylua,
--                 null_ls.builtins.formatting.prettierd,
--                 -- null_ls.builtins.diagnostics.eslint,
--                 -- null_ls.builtins.completion.spell,
--             },
--         })
--     end,
-- }
--

-- nmap(
--     "gf",
--     [[:lua require("conform").format({ async = true, lsp_fallback = true })<CR>]],
--     "[G]oto [F]ormat",
--     true
-- )

return { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format { async = true, lsp_format = 'fallback' }
            end,
            mode = '',
            desc = '[F]ormat buffer',
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = 'never'
            else
                lsp_format_opt = 'fallback'
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt,
            }
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            svelte = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            css = { "prettierd" },
            html = { "prettierd" },
            json = { "prettierd" },
            yaml = { "prettierd" },
            markdown = { "prettierd" },
            graphql = { "prettierd" },
            sh = { "shfmt", "shellharden" },
            bash = { "shfmt", "shellharden" },
            -- Conform can also run multiple formatters sequentially
            -- python = { "isort", "black" },
            --
            -- You can use 'stop_after_first' to run the first available formatter from the list
            -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
    },
}
