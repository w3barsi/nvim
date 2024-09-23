return {
    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup({
                themes = {
                    "catppuccin-frappe",
                    "catppuccin-mocha",
                    "catppuccin-macchiato",
                    "rose-pine-main",
                    "rose-pine-moon",
                    "dracula",
                    "onedark",
                },
            })
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("catppuccin")
        -- end,
    },

    {
        "Mofiqul/dracula.nvim",
        priority = 1000,
        config = function()
            local dracula = require("dracula")
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
            -- vim.cmd.colorscheme("dracula")
        end,
    },

    {
        -- Theme inspired by Atom
        "navarasu/onedark.nvim",
        -- priority = 1000,
        -- config = function()
        --   vim.cmd.colorscheme 'onedark'
        -- end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                highlight_groups = {
                    YankHighlight = { fg = "base", bg = "love" }
                }
            })
        end,

    }

}
