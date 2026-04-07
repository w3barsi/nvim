-- add this to the file where you setup your other plugins:
return {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
        local neocodeium = require("neocodeium")
        neocodeium.setup()
        vim.keymap.set("i", "<A-a>", neocodeium.accept)
        vim.keymap.set("i", "<A-[>", function()
            neocodeium.cycle(-1)
        end)
        vim.keymap.set("i", "<A-]>", function()
            neocodeium.cycle(1)
        end)
        vim.keymap.set("i", "<A-a>", neocodeium.accept)
    end,
}
