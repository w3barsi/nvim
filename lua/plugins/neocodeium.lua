-- add this to the file where you setup your other plugins:
return {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
        require("neocodeium").setup()
    end,
}
