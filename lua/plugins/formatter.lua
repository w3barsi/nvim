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

return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettier" },
                css = { "prettierd" },
                html = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                markdown = { "prettierd" },
                graphql = { "prettierd" },
            },
            -- format_on_save = {
            --     timeout_ms = 500,
            --     async = false,
            --     lsp_fallback = true,
            -- },
        })
    end,
}
