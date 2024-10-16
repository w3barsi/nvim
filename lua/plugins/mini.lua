return {
    'echasnovski/mini.nvim',
    config = function()
        -- vim.api.nvim_set_hl(0, "MiniMiddle", { fg = colors.bright_white, bg = colors.black })
        --
        -- local statusline = require 'mini.statusline'
        --
        -- local my_active_content = function()
        --     local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        --     local git           = MiniStatusline.section_git({ trunc_width = 40 })
        --     local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
        --     local diagnostics   = MiniStatusline.section_diagnostics({
        --         signs = require("config").icons.diagnostics,
        --         trunc_width = 75
        --     })
        --     local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
        --     local filename      = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~")
        --     return MiniStatusline.combine_groups({
        --         { hl = mode_hl,                 strings = { mode } },
        --         { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics, diff } },
        --         '%<', -- Mark general truncate point
        --         { hl = 'MiniMiddle', strings = { filename } },
        --         '%=', -- End left alignment
        --         {
        --             hl = 'MiniStatuslineFileinfo',
        --             strings = {
        --                 vim.bo.filetype ~= ""
        --                 and require("mini.icons").get("filetype", vim.bo.filetype) .. " " .. vim.bo.filetype,
        --             },
        --         },
        --         { hl = mode_hl,      strings = { "%l:%v" } },
        --     })
        -- end
        --
        -- statusline.setup({ use_icons = vim.g.have_nerd_font, content = { active = my_active_content } })
        --
        require('mini.files').setup({
            options = {
                use_as_default_explorer = false
            }
        })
    end,
    keys = {
        { "_", function() MiniFiles.open() end, desc = "Open mini_files" }
    }
}
