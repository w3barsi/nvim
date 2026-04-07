---@module 'lazy'
---@type LazySpec
return {

    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        enabled = true,
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                build = "make",
                "nvim-telescope/telescope-fzf-native.nvim",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_dropdown() },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            ["<esc>"] = actions.close,
                        },
                    },
                    file_ignore_patterns = {
                        "node_modules/*",
                        ".git/*",
                        "convex/_generated",
                    },
                    borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
                },
            })
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "[S]earch by grep" })
        end,
    },
    {
        "dmtrKovalenko/fff.nvim",
        build = function()
            -- this will download prebuild binary or try to use existing rustup toolchain to build from source
            -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
            require("fff.download").download_or_build_binary()
        end,
        lazy = false,
        opts = {
            debug = {
                enabled = true,
                show_scores = true,
            },
            keymaps = {
                move_up = { "<Up>", "<C-k>", "<Tab>" }, -- Multiple bindings supported
                move_down = { "<Down>", "<C-j>", "<S-Tab>" },
            },
        },
        keys = {
            {
                "<C-p>", -- try it if you didn't it is a banger keybinding for a picker
                function()
                    require("fff").find_files() -- or find_in_git_root() if you only want git files
                end,
                desc = "Open file picker",
            },
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        },
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            confirmation = {
                border = "double",
            },
            float = {
                border = "double",
            },
            default_file_explorer = true,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["gp"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                -- ["<Esc>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["<BS>"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            use_default_keymaps = false,
            view_options = {
                show_hidden = true,
            },
        },
        keys = {
            { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
            -- { "_", "<CMD>Oil --float<CR>", desc = "Open parent directory in floating window" },
        },
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
