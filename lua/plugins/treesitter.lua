-- return {}
return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- 'nvim-treesitter/nvim-treesitter-context',
        "nvim-treesitter/playground",

        -- Auto closing tags for HTML
        "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {

        autotag = {
            enable = true,
            enable_close_on_slash = false,
        },

        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
            "c",
            "cpp",
            "go",
            "lua",
            "python",
            "rust",
            "tsx",
            "javascript",
            "typescript",
            "vimdoc",
            "vim",
        },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,

        highlight = { enable = true },
        indent = { enable = false },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<enter>",
                node_incremental = "<enter>",
                scope_incremental = "<c-s>",
                node_decremental = "<bs>",
            },
        },
    },
}
