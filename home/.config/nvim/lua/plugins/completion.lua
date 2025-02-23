-- Completion engine
-- https://github.com/hrsh7th/nvim-cmp

return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        event = "InsertEnter",

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
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
                accept = {
                    auto_brackets = {
                        enabled = true,
                        kind_resolution = {
                            enabled = true,
                            blocked_filetypes = { "markdown", "latex" },
                        },
                        override_brackets_for_filetypes = {},
                    },
                },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                        -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon"} },
                    },
                    cmdline_position = function()
                        -- print(vim.o.columns)
                        return { 6, tonumber(vim.o.columns) / 2 - 29 }
                        -- if vim.g.ui_cmdline_pos ~= nil then
                        --     local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                        --     return { pos[1] - 1, pos[2] }
                        -- end
                        -- local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                        -- return { vim.o.lines - height, 0 }
                    end,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = false,
                },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
                -- cmdline = {},
                -- compat = {},
            },
        },
        ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
        config = function(_, opts)
            -- setup compat sources
            local enabled = opts.sources.default
            for _, source in ipairs(opts.sources.compat or {}) do
                opts.sources.providers[source] = vim.tbl_deep_extend(
                    "force",
                    { name = source, module = "blink.compat.source" },
                    opts.sources.providers[source] or {}
                )
                if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
                    table.insert(enabled, source)
                end
            end

            -- -- add ai_accept to <Tab> key
            -- if not opts.keymap["<Tab>"] then
            --     if opts.keymap.preset == "super-tab" then -- super-tab
            --         opts.keymap["<Tab>"] = {
            --             require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
            --             LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
            --             "fallback",
            --         }
            --     else -- other presets
            --         opts.keymap["<Tab>"] = {
            --             LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
            --             "fallback",
            --         }
            --     end
            -- end

            -- Unset custom prop to pass blink.cmp validation
            opts.sources.compat = nil

            opts.appearance = opts.appearance or {}
            opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, {
                Array = " ",
                Boolean = "󰨙 ",
                Class = " ",
                Codeium = "󰘦 ",
                Color = " ",
                Control = " ",
                Collapsed = " ",
                Constant = "󰏿 ",
                Constructor = " ",
                Copilot = " ",
                Enum = " ",
                EnumMember = " ",
                Event = " ",
                Field = " ",
                File = " ",
                Folder = " ",
                Function = "󰊕 ",
                Interface = " ",
                Key = " ",
                Keyword = " ",
                Method = "󰊕 ",
                Module = " ",
                Namespace = "󰦮 ",
                Null = " ",
                Number = "󰎠 ",
                Object = " ",
                Operator = " ",
                Package = " ",
                Property = " ",
                Reference = " ",
                Snippet = "󱄽 ",
                String = " ",
                Struct = "󰆼 ",
                Supermaven = " ",
                TabNine = "󰏚 ",
                Text = " ",
                TypeParameter = " ",
                Unit = " ",
                Value = " ",
                Variable = "󰀫 ",
            })

            -- check if we need to override symbol kinds
            for _, provider in pairs(opts.sources.providers or {}) do
                ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
                if provider.kind then
                    local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                    local kind_idx = #CompletionItemKind + 1

                    CompletionItemKind[kind_idx] = provider.kind
                    ---@diagnostic disable-next-line: no-unknown
                    CompletionItemKind[provider.kind] = kind_idx

                    ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
                    local transform_items = provider.transform_items
                    ---@param ctx blink.cmp.Context
                    ---@param items blink.cmp.CompletionItem[]
                    provider.transform_items = function(ctx, items)
                        items = transform_items and transform_items(ctx, items) or items
                        for _, item in ipairs(items) do
                            item.kind = kind_idx or item.kind
                        end
                        return items
                    end

                    -- Unset custom prop to pass blink.cmp validation
                    provider.kind = nil
                end
            end

            require("blink.cmp").setup(opts)
        end,

        opts_extend = { "sources.default", "sources.completion.enabled_providers", "sources.compat" },
    },

    {
        "rafamadriz/friendly-snippets",
        -- add blink.compat to dependencies
        {
            "saghen/blink.compat",
            optional = true, -- make optional so it's only enabled if any extras need it
            opts = {},
            version = "*",
        },
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        cmd = "LazyDev",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "LazyVim", words = { "LazyVim" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },
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
