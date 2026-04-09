---@module 'lazy'
---@type LazySpec
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    dependencies = {
        {
            "folke/persistence.nvim",
            event = "BufReadPre", -- this will only start session saving when an actual file was opened
            opts = {
                -- add any custom options here
            },
        },
    },
    opts = {
        dim = { enabled = true },
        dashboard = {},
        rename = { enabled = true },
    },
    keys = {
        {
            "<leader>zm",
            function()
                Snacks.toggle.dim():toggle()
            end,
            desc = "Toggle Dim Mode",
        },
    },
}
