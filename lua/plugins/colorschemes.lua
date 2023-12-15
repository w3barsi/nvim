return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("catppuccin")
        -- end,
    },

    {
        "Mofiqul/dracula.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("dracula")
        end,
    },

    {
        -- Theme inspired by Atom
        "navarasu/onedark.nvim",
        -- priority = 1000,
        -- config = function()
        --   vim.cmd.colorscheme 'onedark'
        -- end,
    },
}
