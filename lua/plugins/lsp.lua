return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",

        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { "j-hui/fidget.nvim",       tag = "legacy", opts = {} },

        { "folke/neodev.nvim",       opts = {} },
        "ray-x/lsp_signature.nvim"
    },
    config = function()
        -- [[ Configure LSP ]]
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            -- NOTE: Remember that lua is a real programming language, and as such it is possible
            -- to define small helper and utility functions so you don't have to repeat yourself
            -- many times.
            --
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local nmap = function(keys, func, desc, silent)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = silent or false })
            end

            nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            nmap("gca", vim.lsp.buf.code_action, "[C]ode [A]ction")

            nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
            nmap("gs", require("telescope.builtin").git_status, "[G]it [S]tatus")
            nmap(
                "gf",
                [[:lua require("conform").format({ async = true, lsp_fallback = true })<CR>]],
                "[G]oto [F]ormat",
                true
            )
            nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
            nmap("gD", vim.lsp.buf.type_definition, "Type [D]efinition")
            -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
            nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

            -- See `:help K` for why this keymap
            nmap("K", vim.lsp.buf.hover, "Hover Documentation")
            -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
            nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
            nmap("<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "[W]orkspace [L]ist Folders")

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })

            nmap("go", ":OrganizeImports<cr>", "Organize Imports", true)
        end

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. They will be passed to
        --  the `settings` field of the server config. You must look up that documentation yourself.
        --
        --  If you want to override the default filetypes that your language server will attach to you can
        --  define the property 'filetypes' to the map in question.
        local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- tsserver = {},
            -- html = { filetypes = { 'html', 'twig', 'hbs'} },

            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        -- Ensure the servers above are installed
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
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

        -- Add organize imports to tsserver
        local function organize_imports()
            local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
            }
            vim.lsp.buf.execute_command(params)
        end

        lspconfig.tsserver.setup({
            commands = {
                OrganizeImports = {
                    organize_imports,
                    description = "Organize Imports",
                },
            },
        })

        require('lsp_signature').setup({})

        local function custom_attach(client, bufnr)
            require("lsp_signature").on_attach({
                bind = true,
                use_lspsaga = false,
                floating_window = true,
                fix_pos = true,
                hint_enable = true,
                hi_parameter = "Search",
                handler_opts = { "double" },
            })
        end

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
    end,
}
