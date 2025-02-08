return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
                -- { path = "snacks.nvim",        words = "Snacks" }
            },
        },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim",          config = true },
            { "williamboman/mason-lspconfig.nvim" },
            { "j-hui/fidget.nvim",                tag = "legacy", opts = {} },
            { "ray-x/lsp_signature.nvim" },
            { "dmmulroy/ts-error-translator.nvim" },
            { "yioneko/nvim-vtsls" }
        },
        config = function()
            local on_attach = function(event, bufnr)
                local opts = { buffer = event.buf }

                local nmap = function(keys, func, desc, silent)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = silent or false })
                end

                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                nmap("gca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                nmap("gs", require("telescope.builtin").git_status, "[G]it [S]tatus")
                -- nmap(
                --     "gf",
                --     [[:lua require("conform").format({ async = true, lsp_fallback = true })<CR>]],
                --     "[G]oto [F]ormat",
                --     true
                -- )
                nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
                nmap("gk", vim.lsp.buf.type_definition, "Type [D]efinition")
                -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")


                -- Lesser used LSP functionality
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- vim.keymap.set({ "n", "x" }, "gf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                nmap(
                    "gf",
                    [[:lua require("conform").format({ async = true, lsp_fallback = true })<CR>]],
                    "[G]oto [F]ormat",
                    true
                )

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                    vim.lsp.buf.format({ async = true })
                end, { desc = "Format current buffer with LSP" })

                nmap("<leader>o", ":VtsExec organize_imports<CR>", "Organize Imports", true)
            end

            local servers = {
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
                "vtsls",
                "astro"
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            -- Ensure the servers above are installed
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
                automatic_installation = true,
                ensure_installed = {
                    "astro",
                    "cssls",
                    "vtsls",
                    "cssmodules_ls",
                    "lua_ls",
                }
            })

            local lspconfig = require("lspconfig")

            mason_lspconfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    })
                end,
                ["vtsls"] = function()
                    require("lspconfig.configs").vtsls = require("vtsls").lspconfig
                    require("lspconfig").vtsls.setup({
                        root_dir = require("lspconfig").util.root_pattern(
                            ".git",
                            "pnpm-workspace.yaml",
                            "pnpm-lock.yaml",
                            "yarn.lock",
                            "package-lock.json",
                            "bun.lockb"
                        ),
                        typescript = {
                            tsserver = {
                                maxTsServerMemory = 12288,
                            },
                        },
                        experimental = {
                            completion = {
                                entriesLimit = 3,
                            },
                        },
                    })
                end,
            })

            -- Add highlights to tailwind color classes
            local tw_highlight = require("tailwind-highlight")

            lspconfig.tailwindcss.setup({
                on_attach = function(client, bufnr)
                    -- rest of you config
                    tw_highlight.setup(client, bufnr, {
                        single_column = false,
                        mode = "background",
                        debounce = 200,
                    })
                end,
            })


            require('lsp_signature').setup({
                floating_window = false
            })

            local ahk2_configs = {
                autostart = true,
                cmd = {
                    "node",
                    vim.fn.expand("$HOME/.config/nvim/languages/vscode-autohotkey2-lsp/server/dist/server.js"),
                    "--stdio"
                },
                filetypes = { "ahk", "autohotkey", "ah2" },
                init_options = {
                    locale = "en-us",
                    InterpreterPath = "/mnt/c/Program Files/AutoHotkey/v2/AutoHotkey.exe",
                    -- Same as initializationOptions for Sublime Text4, convert json literal to lua dictionary literal
                },
                single_file_support = true,
                flags = { debounce_text_changes = 500 },
                capabilities = capabilities,
                on_attach = on_attach,
            }
            local configs = require "lspconfig.configs"
            configs["ahk2"] = { default_config = ahk2_configs }
            local nvim_lsp = require("lspconfig")
            nvim_lsp.ahk2.setup({})

            require("ts-error-translator").setup()
        end,

    },
    -- {
    --     "pmizio/typescript-tools.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --     opts = {},
    -- }
}
