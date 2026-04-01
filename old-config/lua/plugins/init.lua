return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",

    {
        "OlegGulevskyy/better-ts-errors.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            keymaps = {
                toggle = "<leader>dd", -- default '<leader>dd'
                go_to_definition = "<leader>dx", -- default '<leader>dx'
            },
        },
    },

    -- Auto Pairs for brackets and parenthesis
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
        },
    },

    -- Multi Line Editing
    "mg979/vim-visual-multi",

    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    "mbbill/undotree",
    "princejoogie/tailwind-highlight.nvim",

    -- Useful plugin to show you pending keybinds.
    {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = "ibl",
        opts = { scope = { enabled = false } },
    },

    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },
    { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
    {
        "NStefan002/screenkey.nvim",
        cmd = "Screenkey",
        config = true,
    },
    {
        "eero-lehtinen/oklch-color-picker.nvim",
        event = "VeryLazy",
        version = "*",
        keys = {
            -- One handed keymap recommended, you will be using the mouse
            {
                "<leader>v",
                function()
                    require("oklch-color-picker").pick_under_cursor()
                end,
                desc = "Color pick under cursor",
            },
        },
        ---@type oklch.Opts
        opts = {},
    },
    {
        "tzachar/highlight-undo.nvim",
        opts = {},
    },
}
