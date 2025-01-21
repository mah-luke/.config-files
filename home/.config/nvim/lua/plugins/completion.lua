-- Completion engine
-- https://github.com/hrsh7th/nvim-cmp

return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = { preset = "default", ["<M-k>"] = { "show", "show_documentation", "hide_documentation" } },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            use_nvim_cmp_as_default = false,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
            ghost_text = {
                enabled = vim.g.ai_cmp,
            },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
    opts_extend = { "sources.default" },
}

-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     -- luasnip
--     { "L3MON4D3/LuaSnip", version = "*", run = "make install_jsregexp" },
--     -- completion plugins
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-nvim-lua",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "kdheepak/cmp-latex-symbols",
--     "saadparwaiz1/cmp_luasnip",
--     -- pictograms
--     "onsails/lspkind.nvim",
--     -- jupyter
--     "jmbuhr/otter.nvim"
--   },
--   opts = function()
--     local cmp = require("cmp")
--     return {
--       snippet = {
--         expand = function(args)
--           require("luasnip").lsp_expand(args.body)
--         end,
--       },
--       window = {
--         -- completion = cmp.config.window.bordered(),
--         -- documentation = cmp.config.window.bordered(),
--       },
--       mapping = {
--         -- ":help ins-completion"
--         ["<c-p>"] = cmp.mapping.select_prev_item(),
--         ["<c-n>"] = cmp.mapping.select_next_item(),
--         ["<c-b>"] = cmp.mapping.scroll_docs(-4),
--         ["<c-f>"] = cmp.mapping.scroll_docs(4),
--         ["<c-d>"] = cmp.mapping.scroll_docs(-4),
--         ["<c-u>"] = cmp.mapping.scroll_docs(4),
--         ["<c-c>"] = cmp.mapping.complete(),
--         ["<c-e>"] = cmp.mapping.abort(),
--         ["<c-y>"] = cmp.mapping.confirm({ select = true }),
--       },
--       formatting = {
--         format = require("lspkind").cmp_format({
--           with_text = true,
--           menu = {
--             nvim_lsp = "[LSP]",
--             nvim_lua = "[LUA]",
--             luasnip = "[SNIP]",
--             latex_symbols = "[LATEX]",
--             buffer = "[BUF]",
--             path = "[PATH]",
--             otter = "[OTTER]",
--           },
--         }),
--       },
--       sources = {
--         { name = "nvim_lsp" },
--         { name = "nvim_lua" },
--         { name = "otter" },
--         { name = "luasnip" },
--         { name = "latex_symbols" },
--         { name = "buffer" },
--         { name = "path" },
--       },
--       confirm_opts = {
--         behavior = cmp.ConfirmBehavior.Replace,
--         select = false,
--       },
--     }
--   end,
-- }
