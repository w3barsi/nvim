return {
    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup({
                themes = {
                    "catppuccin-mocha",
                    "rose-pine-main",
                    "rose-pine-moon",
                    "rose-pine-dawn",
                    "dracula",
                    "dracula-soft",
                },
            })
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    fidget = true,
                    gitsigns = true,
                    harpoon = true,
                    indent_blankline = {
                        enabled = false,
                        scope_color = "sapphire",
                        colored_indent_levels = false,
                    },
                    mason = true,
                    native_lsp = { enabled = true },
                    noice = true,
                    notify = true,
                    symbols_outline = true,
                    telescope = true,
                    treesitter = true,
                    treesitter_context = true,
                },
                custom_highlights = function(colors)
                    return {
                        YankHighlight = { fg = colors.base, bg = colors.red },
                        ["@variable.member.typescript"] = { fg = colors.red },
                        ["@lsp.type.property.typescript"] = { fg = colors.blue },
                        ["@lsp.typemod.property.declaration.typescript"] = { fg = colors.lavender },
                        -- ["@punctuation.bracket.typescript"] = { fg = colors.text },
                    }
                end,
            })

            vim.cmd.colorscheme("catppuccin-mocha")
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

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
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
        end,
    },
}
