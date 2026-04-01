---@module 'lazy'
---@type LazySpec
return {
    { "NMAC427/guess-indent.nvim", opts = {} },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        ---@module 'gitsigns'
        ---@type Gitsigns.Config
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            signs = {
                -- add = { text = '+' }, ---@diagnostic disable-line: missing-fields
                -- change = { text = '~' }, ---@diagnostic disable-line: missing-fields
                -- delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
                -- topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
                -- changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
                add = { text = "▎" }, ---@diagnostic disable-line: missing-fields
                change = { text = "▎" }, ---@diagnostic disable-line: missing-fields
                delete = { text = "" }, ---@diagnostic disable-line: missing-fields
                topdelete = { text = "" }, ---@diagnostic disable-line: missing-fields
                changedelete = { text = "▎" }, ---@diagnostic disable-line: missing-fields
                untracked = { text = "▎" }, ---@diagnostic disable-line: missing-fields
            },
        },
    },
    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter",
        ---@module 'which-key'
        ---@type wk.Opts
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            delay = 0,
            icons = { mappings = vim.g.have_nerd_font },
            spec = {
                { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
                { "gr", group = "LSP Actions", mode = { "n" } },
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {
            scope = {
                enabled = false,
            },
        },
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
            vim.cmd.colorscheme("rose-pine-main")
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        ---@module 'todo-comments'
        ---@type TodoOptions
        ---@diagnostic disable-next-line: missing-fields
        opts = { signs = false },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },

    -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    -- require 'kickstart.plugins.neo-tree',
    -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommended keymaps

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    -- { import = 'custom.plugins' },
    --
    -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
    -- Or use telescope!
    -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
    -- you can continue same window with `<space>sr` which resumes last telescope search
}
