-- Language Server Protocol LSP
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- https://github.com/mfussenegger/nvim-jdtls
-- https://github.com/barreiroleo/ltex_extra.nvim

-- Spell dict for LaTeX
local function words()
    local result = {}
    local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
    for word in io.open(path, "r"):lines() do
        table.insert(result, word)
    end
    return result
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
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

            -- Lua
            lspconfig.lua_ls.setup({
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
                capabilities = lsp_conf.capabilities,
                flags = lsp_conf.lsp_flags,
                on_attach = lsp_conf.on_attach,
            })

            -- Python
            lspconfig.pyright.setup({
                capabilities = lsp_conf.capabilities,
                flags = lsp_conf.lsp_flags,
                on_attach = lsp_conf.on_attach,
                settings = {
                    python = {
                        analysis = {
                            diagnosticSeverityOverrides = {
                                reportUnusedExpression = "none",
                            },
                        },
                    },
                },
            })

            -- Rust

            -- Latex
            -- lspconfig.ltex.setup({
            --     settings = {
            --         ltex = {
            --             language = "en-US",
            --             dictionary = {
            --                 ["en-US"] = words() or {},
            --             },
            --         },
            --     },
            --     capabilities = lsp_conf.capabilities,
            --     flags = lsp_conf.lsp_flags,
            --     on_attach = lsp_conf.on_attach,
            -- })
            -- lspconfig.texlab.setup({
            --     capabilities = lsp_conf.capabilities,
            --     flags = lsp_conf.lsp_flags,
            --     on_attach = lsp_conf.on_attach,
            -- })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
      -- stylua: ignore
      { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format current buffer" },
        },
        opts = function()
            local null_ls = require("null-ls")
            return {
                -- on_attach = function(client, bufnr)
                -- if client.supports_method("textDocument/formatting") then
                --     local augroup = vim.api.nvim_create_augroup("LspFromatting", { clear = true })
                --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                --     vim.api.nvim_create_autocmd("BufWritePre", {
                --         group = augroup,
                --         buffer = bufnr,
                --         callback = function()
                --             vim.lsp.buf.format({ async = false })
                --         end,
                --     })
                -- end
                -- nd,
                sources = {
                    -- lua
                    null_ls.builtins.formatting.stylua,
                    -- python
                    null_ls.builtins.diagnostics.flake8.with({
                        extra_args = {
                            "--max-line-length",
                            "88",
                            "--extend-ignore",
                            "E203",
                        },
                    }),
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.formatting.black,
                    -- sh
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.formatting.shfmt.with({
                        extra_args = {
                            "--indent",
                            "4",
                            "--binary-next-line",
                            "--case-indent",
                            "--space-redirects",
                        },
                    }),
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
        ft = {"markdown", "tex"},
        dependencies = {"neovim/nvim-lspconfig"}
    },
}
