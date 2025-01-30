-- Use Mason as package manager for LSP, DAP, linters, formatters.
-- https://github.com/williamboman/mason.nvim

return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ensure_installed = {
                -- Java
                "jdtls", -- LSP
                "java-debug-adapter", -- DAP
                "java-test", -- DAP
                -- Lua
                "lua-language-server", -- LSP
                "stylua", -- formatter
                -- Python
                "debugpy", -- DAP
                "ruff", -- LSP & Formatter & Linter
                "pyright",
                -- Shell
                "bash-language-server", -- LSP
                -- Rust
                "codelldb", -- debug for C, C++ & Rust
                "rust-analyzer",
                "bacon-ls",
                -- C / C++
                "clangd",
                -- Make
                "autotools-language-server",
                -- Latex
                "latexindent",
                "ltex-ls",
                "texlab",
                -- Security
                "trivy",
                -- Formatting
                "prettierd", -- Markdown and many others
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
}
