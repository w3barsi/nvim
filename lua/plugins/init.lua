return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",

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
    "ThePrimeagen/harpoon",

    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    -- Motions for surround tags
    "tpope/vim-surround",

    "mbbill/undotree",
    "princejoogie/tailwind-highlight.nvim",

    { "kdheepak/lazygit.nvim", event = "VeryLazy" },

    -- Useful plugin to show you pending keybinds.
    { "folke/which-key.nvim", opts = {} },

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
}
