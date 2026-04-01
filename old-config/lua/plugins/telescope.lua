return {
    {

        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
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
                },
            })

            pcall(require("telescope").load_extension, "fzf")

            local builtin = require("telescope.builtin")
            -- vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
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
}
