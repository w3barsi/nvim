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

    -- Auto closing tags for HTML
    "windwp/nvim-ts-autotag",

    -- Multi Line Editing
    "mg979/vim-visual-multi",

    -- Project file navigation
    "ThePrimeagen/harpoon",

    -- Git related plugins
    "kdheepak/lazygit.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    -- Motions for surround tags
    "tpope/vim-surround",

    "mbbill/undotree",
    "princejoogie/tailwind-highlight.nvim",

    -- Useful plugin to show you pending keybinds.
    { "folke/which-key.nvim", opts = {} },

    {
        -- Set lualine as statusline
        "nvim-lualine/lualine.nvim",
        -- See `:help lualine.txt`
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
    },

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
}
