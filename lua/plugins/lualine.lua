return {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    --
    event = "VeryLazy",
    opts = {
        options = {
            icons_enabled = false,
            component_separators = "|",
            section_separators = "",
        },
        sections = {
            lualine_c = {
                {
                    "filename",
                    path = 1,
                },
            },
        },
    },
}
