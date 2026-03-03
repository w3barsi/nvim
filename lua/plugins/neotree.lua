return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
        keys = {
            { "<C-e>", "<cmd>Neotree toggle<cr>" },
        },
        opts = {
            close_if_last_window = true,
            window = {
                position = "right",
            },
            filesystem = {
                follow_current_file = {
                    enabled = true, -- Auto-follow current file
                    leave_dirs_open = false, -- Auto-collapse expanded dirs when moving to other files
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
            },
        },
    },
}
