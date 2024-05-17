-- Guide: https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md
return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        dependencies = { "3rd/image.nvim" },
        config = function()
            -- I find auto open annoying, keep in mind setting this option will require setting
            -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
            vim.g.molten_auto_open_output = false

            -- this guide will be using image.nvim
            -- Don't forget to setup and install the plugin if you want to view image outputs
            vim.g.molten_image_provider = "image.nvim"

            -- optional, I like wrapping. works for virt text and the output window
            vim.g.molten_wrap_output = true

            -- Output as virtual text. Allows outputs to always be shown, works with images, but can
            -- be buggy with longer images
            vim.g.molten_virt_text_output = true

            -- this will make it so the output shows up below the \`\`\` cell delimiter
            vim.g.molten_virt_lines_off_by_1 = true

            vim.keymap.set(
                "n",
                "<localleader>e",
                ":MoltenEvaluateOperator<CR>",
                { desc = "evaluate operator", silent = true }
            )
            vim.keymap.set(
                "n",
                "<localleader>os",
                ":noautocmd MoltenEnterOutput<CR>",
                { desc = "open output window", silent = true }
            )
            vim.keymap.set(
                "n",
                "<localleader>rr",
                ":MoltenReevaluateCell<CR>",
                { desc = "re-eval cell", silent = true }
            )
            vim.keymap.set(
                "v",
                "<localleader>r",
                ":<C-u>MoltenEvaluateVisual<CR>gv",
                { desc = "execute visual selection", silent = true }
            )
            vim.keymap.set(
                "n",
                "<localleader>oh",
                ":MoltenHideOutput<CR>",
                { desc = "close output window", silent = true }
            )
            vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

            -- if you work with html outputs:
            vim.keymap.set(
                "n",
                "<localleader>mx",
                ":MoltenOpenInBrowser<CR>",
                { desc = "open output in browser", silent = true }
            )
        end,
    },
    {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        dependencies = { "luarocks.nvim" },
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },

    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },

    -- {
    --     "quarto-dev/quarto-nvim",
    --     ft = { "quarto", "markdown" },
    --     dependencies = { "jmbuhr/otter.nvim" },
    --     opts = {
    --         lspFeatures = {
    --             -- NOTE: put whatever languages you want here:
    --             languages = { "r", "python", "rust", "java", "html" },
    --             chunks = "all",
    --             diagnostics = {
    --                 enabled = true,
    --                 triggers = { "BufWritePost" },
    --             },
    --             completion = {
    --                 enabled = true,
    --             },
    --         },
    --         keymap = {
    --             -- NOTE: setup your own keymaps:
    --             hover = "H",
    --             definition = "gd",
    --             rename = "<leader>rn",
    --             references = "gr",
    --             format = "<leader>gf",
    --         },
    --         codeRunner = {
    --             enabled = true,
    --             default_method = "molten",
    --         },
    --     },
    --     config = function()
    --         local runner = require("quarto.runner")
    --         vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
    --         vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
    --         vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
    --         vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
    --         vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
    --         vim.keymap.set("n", "<localleader>RA", function()
    --             runner.run_all(true)
    --         end, { desc = "run all cells of all languages", silent = true })
    --     end,
    -- },

    -- {
    --     "jmbuhr/otter.nvim",
    --     opts = {
    --         lsp = {
    --             -- hover = {
    --             --     border = require("misc.style").border,
    --             -- },
    --         },
    --         diagnostic_update_events = { "BufWritePost" },
    --         buffers = {
    --             set_filetype = true,
    --             -- write_to_disk = false,
    --         },
    --         handle_leading_whitespace = true,
    --         languages = {'python', 'lua', 'rust', 'r'},
    --     },
    -- },

    -- {
    --     -- https://github.com/goerz/jupytext.vim
    --     -- jupytext: render .ipynb as markdown
    --     -- TODO: Has to open another file otherwise ipynb not rendered as py
    --     "goerz/jupytext.vim",
    --     -- ft = "json",
    --     lazy = false,
    --     config = function()
    --         vim.g.jupytext_fmt = "py:percent"
    --         -- vim.g.jupytext_filetype_map = { py = "python"}
    --     end,
    --     event = { "BufReadPost", "BufNewFile" },
    -- },
    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            -- style = "markdown",
            -- output_extension = "md",
            -- force_ft = "markdown",
        },
    },
}
