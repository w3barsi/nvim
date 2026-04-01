-- LUALINE
return {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    event = "VeryLazy",
    opts = {
        icons_enabled = true,
        options = {
            icons_enabled = false,
            component_separators = "",
            section_separators = "",
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                {
                    "branch",
                },
                {
                    "diff",
                    icons_enabled = true,
                    symbols = require("config").icons.git,
                },
                {
                    "diagnostics",
                    icons_enabled = true,
                }
            },
            lualine_c = {
                "%=",
                {
                    "filename",
                    path = 3,
                },
            },
            lualine_x = {},
            lualine_y = { { "filetype", icons_enabled = true } },
            lualine_z = { { "location" } },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                "%=",
                {
                    "filename",
                    path = 3,
                }
            },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        }
    }

}
