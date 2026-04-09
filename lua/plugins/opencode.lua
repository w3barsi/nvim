return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
        {
            -- `snacks.nvim` integration is recommended, but optional
            ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
            "folke/snacks.nvim",
            opts = {
                input = {}, -- Enhances `ask()`
            },
        },
    },
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {}

        vim.o.autoread = true -- Required for `opts.events.reload`
        -- Recommended/example keymaps

        vim.keymap.set({ "n", "x" }, "<leader>a", function()
            require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask opencode…" })
    end,
}
