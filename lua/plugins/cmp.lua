---@module 'lazy'
---@type LazySpec
return { -- Autocompletion
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
        -- Snippet Engine
        {
            "L3MON4D3/LuaSnip",
            version = "2.*",
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                -- {
                --   'rafamadriz/friendly-snippets',
                --   config = function()
                --     require('luasnip.loaders.from_vscode').lazy_load()
                --   end,
                -- },
            },
            opts = {},
        },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            -- 'default' (recommended) for mappings similar to built-in completions
            --   <c-y> to accept ([y]es) the completion.
            --    This will auto-import if your LSP supports it.
            --    This will expand snippets if the LSP sent a snippet.
            -- 'super-tab' for tab to accept
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- For an understanding of why the 'default' preset is recommended,
            -- you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            --
            -- All presets have the following mappings:
            -- <tab>/<s-tab>: move to right/left of your snippet expansion
            -- <c-space>: Open menu or open docs if already open
            -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
            -- <c-e>: Hide menu
            -- <c-k>: Toggle signature help
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            preset = "none",
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                lsp = {
                    score_offset = 1000, -- Extreme priority to override fuzzy matching
                },
                path = {
                    score_offset = 3, -- File paths moderate priority
                },
                snippets = {
                    score_offset = -100, -- Much lower priority
                    max_items = 2, -- Limit snippet suggestions
                    min_keyword_length = 3, -- Don't show for single chars
                },
                buffer = {
                    score_offset = -150, -- Lowest priority
                    min_keyword_length = 3, -- Only show after 3 chars
                },
            },
        },
        snippets = { preset = "luasnip" },
        fuzzy = { implementation = "lua" },
        signature = {
            enabled = true,
            trigger = {
                show_on_trigger_character = false,
                show_on_insert_on_trigger_character = false,
            },
            window = {
                border = "double",
                show_documentation = true,
            },
        },
        completion = {
            trigger = {
                show_in_snippet = false,
                show_on_trigger_character = false,
            },
            menu = {
                border = "double",
                max_height = 10,
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "source_name" },
                    },
                    components = {
                        -- Native icon support (no lspkind needed)
                        source_name = {
                            text = function(ctx)
                                local source_names = {
                                    lsp = "[LSP]",
                                    buffer = "[Buffer]",
                                    path = "[Path]",
                                    snippets = "[Snippet]",
                                }
                                return (source_names[ctx.source_name] or "[") .. ctx.source_name .. "]"
                            end,
                            highlight = "CmpItemMenu",
                        },
                    },
                },
                auto_show = true,
            },
            documentation = {
                auto_show = true,
                window = {
                    border = "double",
                },
            },
            ghost_text = {
                enabled = true,
            },
            list = {
                selection = {
                    preselect = false,
                },
            },
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
        },
    },
}
