return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                -- { path = "snacks.nvim",        words = "Snacks" }
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true, version = "1.11.0" },
            { "williamboman/mason-lspconfig.nvim", version = "v1.32.0" },
            { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
            { "ray-x/lsp_signature.nvim" },
            { "dmmulroy/ts-error-translator.nvim" },
            { "yioneko/nvim-vtsls" },
        },
        config = function()
            --------------------------------------------------------------------------------
            -- Highlight references START
            --------------------------------------------------------------------------------
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                    ---@param client vim.lsp.Client
                    ---@param method vim.lsp.protocol.Method
                    ---@param bufnr? integer some lsp support methods only in specific files
                    ---@return boolean
                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has("nvim-0.11") == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client:supports_method(method, { bufnr = bufnr })
                        end
                    end

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client_supports_method(
                            client,
                            vim.lsp.protocol.Methods.textDocument_documentHighlight,
                            event.buf
                        )
                    then
                        local highlight_augroup =
                            vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                            end,
                        })
                    end
                end,
            })
            --------------------------------------------------------------------------------
            -- Highlight references END
            --------------------------------------------------------------------------------

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
                    [[:lua require("conform").format({ async = false, lsp_fallback = true })<CR>]],
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
                "astro",
                "biome",
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            local biome_on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.code_action({
                            filter = function(action)
                                return action.kind == "source.organizeImports.biome"
                            end,
                            apply = true,
                            context = {
                                only = { "quickfix" },
                                diagnostics = vim.diagnostic.get(bufnr, { client_id = client.id }),
                            },
                        })
                    end,
                })
            end

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
                    "biome",
                },
            })
            local lspconfig = require("lspconfig")
            local tw_highlight = require("tailwind-highlight")

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
                ["biome"] = function()
                    lspconfig.biome.setup({ capabilities = capabilities, on_attach = biome_on_attach })
                end,
                ["tailwindcss"] = function()
                    lspconfig.tailwindcss.setup({
                        settings = {
                            tailwindCSS = {
                                classAttributes = {
                                    "class",
                                    "className",
                                    "class\\w*",
                                    "className\\w*",
                                    "\\w+Class",
                                    "\\w+ClassName",
                                },
                            },
                        },
                        on_attach = function(client, bufnr)
                            -- rest of you config
                            tw_highlight.setup(client, bufnr, {
                                single_column = false,
                                mode = "background",
                                debounce = 200,
                            })
                        end,
                    })
                end,
            })

            -- Add highlights to tailwind color classes

            require("lsp_signature").setup({
                floating_window = false,
            })

            local configs = require("lspconfig.configs")
            configs["ahk2"] = {
                default_config = {
                    autostart = true,
                    cmd = {
                        "node",
                        vim.fn.expand("$HOME/.config/nvim/languages/vscode-autohotkey2-lsp/server/dist/server.js"),
                        "--stdio",
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
                },
            }
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
