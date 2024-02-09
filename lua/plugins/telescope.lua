return {

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
            },
        })

        pcall(require("telescope").load_extension, "fzf")

        -- vim.keymap.set("n", "<ieader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
        vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
        -- vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set(
            "n",
            "<C-p>",
            "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
            { noremap = true }
        )
        vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set(
            "n",
            "<leader>sw",
            require("telescope.builtin").grep_string,
            { desc = "[S]earch current [W]ord" }
        )
        vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<C-f>", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
    end,
}
