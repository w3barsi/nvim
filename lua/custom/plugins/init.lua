-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return { -- NOTE: First, some plugins that don't require any configuration
    -- Dependencies
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",

    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "*",
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                    },
                    hijack_netrw_behavior = "disabled",
                },
            })
        end,
    },

    {
        -- 'windwp/nvim-autopairs',
        -- opts = {}, -- this is equalent to setup({}) function
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        -- Optional dependency
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
            })
        end,
    },

    -- Multi Line Editing
    "mg979/vim-visual-multi",

    -- Project file navigation
    "ThePrimeagen/harpoon",

    "windwp/nvim-ts-autotag",

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

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            { "folke/neodev.nvim", opts = {} },
        },
    },

    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path",

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",

            -- Adds a number of user-friendly snippets
            "rafamadriz/friendly-snippets",
        },
    },

    -- Useful plugin to show you pending keybinds.
    { "folke/which-key.nvim", opts = {} },

    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            on_attach = function(bufnr)
                vim.keymap.set(
                    "n",
                    "<leader>gp",
                    require("gitsigns").prev_hunk,
                    { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>gn",
                    require("gitsigns").next_hunk,
                    { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>ph",
                    require("gitsigns").preview_hunk,
                    { buffer = bufnr, desc = "[P]review [H]unk" }
                )
            end,
        },
    },
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
