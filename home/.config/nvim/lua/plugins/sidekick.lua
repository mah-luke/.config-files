return {
    {
        "folke/sidekick.nvim",
        dependencies = { "folke/snacks.nvim" },
        opts = {},
        config = function(_, opts)
            require("sidekick").setup(opts)
            if package.loaded["snacks"] then
                local Snacks = require("snacks")
                Snacks.toggle({
                    name = "Sidekick NES",
                    get = function()
                        return require("sidekick.nes").enabled
                    end,
                    set = function(state)
                        require("sidekick.nes").enable(state)
                    end,
                }):map("<leader>uN")
            end
        end,
        keys = {
            {
                "<tab>",
                function()
                    if require("sidekick").nes_jump_or_apply() then
                        return ""
                    end
                    return "<tab>"
                end,
                mode = { "n" },
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
            {
                "<c-.>",
                function() require("sidekick.cli").focus() end,
                desc = "Sidekick Focus",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function() require("sidekick.cli").close() end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
        },
    },
    {
        "folke/snacks.nvim",
        optional = true,
        opts = {
            picker = {
                actions = {
                    sidekick_send = function(...)
                        return require("sidekick.cli.picker.snacks").send(...)
                    end,
                },
                win = {
                    input = {
                        keys = {
                            ["<a-a>"] = {
                                "sidekick_send",
                                mode = { "n", "i" },
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            local icons = {
                idle = { "󰔛 ", "hl-msg" },
                busy = { "󰔟 ", "hl-msg" },
                error = { "󰅙 ", "hl-error" },
            }
            if not opts.sections then
                opts.sections = {}
            end
            if not opts.sections.lualine_x then
                opts.sections.lualine_x = {}
            end
            table.insert(opts.sections.lualine_x, 2, {
                function()
                    local status = require("sidekick.status").get()
                    return status and (icons[status.kind] and icons[status.kind][1] or "") or ""
                end,
                cond = function()
                    local ok, status = pcall(require, "sidekick.status")
                    return ok and status.get() ~= nil
                end,
            })
            table.insert(opts.sections.lualine_x, 2, {
                function()
                    local cli = require("sidekick.status").cli()
                    return " " .. (#cli > 1 and #cli or "")
                end,
                cond = function()
                    local ok, status = pcall(require, "sidekick.status")
                    return ok and #status.cli() > 0
                end,
            })
        end,
    },
}
