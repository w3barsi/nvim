return {

    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup({
                themes = {
                    "gruvbox",
                    "rose-pine-main",
                    "dracula",
                },
            })
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("rose-pine").setup({
                styles = {
                    italic = false,
                },
                highlight_groups = {
                    YankHighlight = { fg = "base", bg = "love" },
                    CodeiumSuggestion = { fg = "#7AA67A" },
                    ["@string.bash"] = { fg = "#7AA67A" },
                    LspReferenceText = { bg = "#000000" },
                    LspReferenceRead = { bg = "#000000" },
                    LspReferenceWrite = { bg = "#000000" },
                },
            })
            vim.cmd.colorscheme("rose-pine-main")
        end,
    },

    {
        "Mofiqul/dracula.nvim",
        priority = 1000,
        config = function()
            local dracula = require("dracula")
            ---@diagnostic disable-next-line: missing-fields
            dracula.setup({
                overrides = function(colors)
                    return {
                        CursorLine = { bg = colors.menu },
                        ["@tag.delimiter"] = { fg = colors.bright_white },
                        NormalFloat = { bg = colors.menu },
                        TelescopeNormal = { fg = colors.fg, bg = colors.menu },

                        TelescopeResultsTitle = { fg = colors.bg, bg = colors.pink },
                        TelescopeResultsBorder = { fg = colors.menu, bg = colors.menu },

                        TelescopePreviewTitle = { fg = colors.bg, bg = colors.pink },
                        TelescopePreviewBorder = { fg = colors.bg, bg = colors.menu },

                        TelescopePromptBorder = { fg = colors.bg, bg = colors.pink },
                        TelescopePromptNormal = { fg = colors.bg, bg = colors.pink },
                        TelescopePromptTitle = { fg = colors.bg, bg = colors.pink },
                        TelescopePromptPrefix = { fg = colors.bg, bg = colors.pink },

                        YankHighlight = { fg = colors.bg, bg = colors.pink },
                    }
                end,
            })
        end,
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
    { "Mofiqul/dracula.nvim" },
}
