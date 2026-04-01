return {
    { ---@type LazyPluginSpec
        "Exafunction/windsurf.nvim",
        name = "codeium.nvim",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "InsertEnter",
        config = true,
        opts = {
            enable_chat = false,
            quiet = true,
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                idle_delay = 50,
                key_bindings = {
                    accept = "<C-\\>",
                    accept_line = "<F10>",
                },
            },
        },
    },
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<C-\\>",
                },
                color = {
                    suggestion_color = "#7AA67A",
                },
            })
        end,
    },
}
