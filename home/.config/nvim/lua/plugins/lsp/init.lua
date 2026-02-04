-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- https://github.com/mfussenegger/nvim-jdtls
-- https://github.com/barreiroleo/ltex_extra.nvim

-- Spell dict for LaTeX
-- local function words()
--     local result = {}
--     local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
--     for word in io.open(path, "r"):lines() do
--         table.insert(result, word)
--     end
--     return result
-- end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            -- Keymaps
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            local function nmap(lhs, rhs, desc)
                vim.keymap.set("n", lhs, rhs, { desc = desc })
            end
            nmap("<leader>ld", vim.diagnostic.open_float, "Diagnostic open float")
            nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
            nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
            nmap("<leader>q", vim.diagnostic.setloclist, "Diagnostic set loclist")

            local lspconfig = require("lspconfig")
            local lsp_conf = require("plugins.lsp.config")
            local util = require("lspconfig/util")

            local servers = {

                -- Lua
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = {
                                globals = {
                                    "vim",
                                },
                            },
                            format = { enable = false },
                            workspace = {
                                checkThirdParty = false,
                            },
                            telemetry = { enable = false },
                        },
                    },
                },

                -- Python
                ruff = {},
                basedpyright = {
                    analysis = {
                        diagnosticSeverityOverrides = {
                            reportUnusedExpression = "none",
                        },
                    },
                },

                -- Shell
                bashls = {
                    filetypes = { "sh", "zsh" },
                },

                -- Rust
                -- rust_analyzer = {enabled = false},
                bacon_ls = {
                    enabled = false,
                },

                -- C
                clangd = {
                    keys = {
                        {
                            "<leader>ch",
                            "<cmd>ClangdSwitchSourceHeader<cr>",
                            desc = "Switch Source/Header (C/C++)",
                        },
                    },
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            "Makefile",
                            "configure.ac",
                            "configure.in",
                            "config.h.in",
                            "meson.build",
                            "meson_options.txt",
                            "build.ninja"
                        )(fname) or require("lspconfig.util").root_pattern(
                            "compile_commands.json",
                            "compile_flags.txt"
                        )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                    end,
                    capabilities = {
                        offsetEncoding = { "utf-16" },
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=LLVM",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },

                -- Latex
                ltex = {
                    settings = {
                        ltex = {
                            language = { "en-US", "de-AT" }, -- "auto"
                            checkFrequency = "save",
                            -- dictionary = {
                            --     ["en-US"] = words() or {},
                            -- },
                            -- additionalRules = {
                            --     enablePickyRules = true,
                            --     motherTongue = "de-AT",
                            -- },
                        },
                    },
                },

                -- R
                air = {},
                r_language_server = {},

                texlab = {
                    filetypes = { "tex", "plaintex", "bib", "markdown" },
                },
            }
            for name, config in pairs(servers) do
                config = vim.tbl_deep_extend("force", {}, {
                    capabilities = lsp_conf.capabilities,
                    flags = lsp_conf.lsp_flags,
                    on_attach = lsp_conf.on_attach,
                }, config)
                lspconfig[name].setup(config)
            end
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            -- stylua: ignore
            { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format current buffer" },
        },
        opts = function()
            local nls = require("null-ls")
            return {
                on_attach = function(client, bufnr)
                    -- if client.supports_method("textDocument/formatting") then
                    --     local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
                    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    --     vim.api.nvim_create_autocmd("BufWritePre", {
                    --         group = augroup,
                    --         buffer = bufnr,
                    --         callback = function()
                    --             vim.lsp.buf.format({ async = false })
                    --         end,
                    --     })
                    -- end
                end,
                sources = {
                    -- lua
                    nls.builtins.formatting.stylua,
                    -- python
                    -- nls.builtins.diagnostics.flake8.with({
                    --     extra_args = {
                    --         "--max-line-length",
                    --         "88",
                    --         "--extend-ignore",
                    --         "E203",
                    --     },
                    -- }),
                    -- nls.builtins.diagnostics.mypy,
                    -- nls.builtins.formatting.black,
                    -- sh
                    nls.builtins.formatting.shfmt.with({
                        filetypes = { "sh", "bash", "zsh" },
                        extra_args = {
                            "--indent",
                            "4",
                            "--binary-next-line",
                            "--case-indent",
                            "--space-redirects",
                        },
                    }),
                    nls.builtins.formatting.prettierd.with({}),
                    -- nls.builtins.formatting.shellharden,
                },
            }
        end,
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
    },
    {
        "barreiroleo/ltex_extra.nvim",
        branch = "dev",
        ft = { "markdown", "tex" },
        opts = {
            load_langs = { "en-US", "de-AT" },
            path = "~/.config/ltex",
        },
        dependencies = { "neovim/nvim-lspconfig" },
    },
    { "williamboman/mason-lspconfig.nvim" },
}
