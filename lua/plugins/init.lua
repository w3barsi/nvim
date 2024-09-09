return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",

    {
        "OlegGulevskyy/better-ts-errors.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = {
            keymaps = {
                toggle = "<leader>dd",           -- default '<leader>dd'
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

    -- Project file navigation
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true
            }
        }
    },

    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    -- Motions for surround tags
    "tpope/vim-surround",

    "mbbill/undotree",
    "princejoogie/tailwind-highlight.nvim",

    { "kdheepak/lazygit.nvim",                       event = "VeryLazy" },

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
    { "numToStr/Comment.nvim",                       opts = {} },
    { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
    {
        "NStefan002/screenkey.nvim",
        cmd = "Screenkey",
        config = true,
    },
}
