-- Plugins to allow REPL in neovim
-- Guide: https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md
--

local function keys(str)
    return function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
    end
end

return {
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

            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    filetypes = { "markdown", "quarto" }, -- markdown extensions (ie. quarto) can go here
                },
            },
        },
    },

    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },

    -- TODO: setup hydra
    {
        "nvimtools/hydra.nvim",
        version = "*",
        config = function()
            local hydra = require("hydra")
            hydra({
                name = "QuartoNavigator",
                hint = [[
_j_/_k_: move down/up  _r_: run cell
_l_: run line  _R_: run above
^^     _<esc>_/_q_: exit ]],
                config = {
                    color = "pink",
                    invoke_on_body = true,
                    -- hint = {
                    --     -- border = "rounded", -- you can change the border if you want
                    -- },
                },
                mode = { "n" },
                body = "<leader>j", -- this is the key that triggers the hydra
                heads = {
                    { "j", keys("]b") },
                    { "k", keys("[b") },
                    { "r", ":QuartoSend<CR>" },
                    { "l", ":QuartoSendLine<CR>" },
                    { "R", ":QuartoSendAbove<CR>" },
                    { "<esc>", nil, { exit = true } },
                    { "q", nil, { exit = true } },
                },
            })
        end,
    },

    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
            -- style = "hydrogen",
            -- output_extension = "py",
            -- force_ft = "python"
        },
    },
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                opts = {
                    handle_leading_whitespace = true,
                    lsp = {
                        -- enabled = true,
                        hover = { border = "none" },
                    },
                    -- diagnostic_update_events = { "BufWritePost" },
                    --     set_filetype = true,
                    -- buffers = {
                    --     write_to_disk = true,
                    -- },
                },
            },
            "nvim-cmp",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            { "nvimtools/hydra.nvim" },
        },
        ft = { "quarto", "markdown" },
        config = function()
            local quarto = require("quarto")
            quarto.setup({
                lspFeatures = {
                    languages = { "python", "rust", "lua" },
                    chunks = "all", -- 'curly' or 'all'
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                -- keymap only activated for quarto files, manually done in ftplugin/markdown.lua for md
                keymap = {
                    hover = "K",
                    definition = "gd",
                    rename = "<leader>rn",
                    references = "gr",
                    format = "<leader>lf",
                },
                codeRunner = {
                    enabled = true,
                    ft_runners = {
                        bash = "slime",
                    },
                    default_method = "molten",
                },
            })

            vim.keymap.set(
                "n",
                "<localleader>qp",
                quarto.quartoPreview,
                { desc = "Preview the Quarto document", silent = true, noremap = true }
            )
            -- to create a cell in insert mode, I have the ` snippet
            vim.keymap.set(
                "n",
                "<localleader>cc",
                "i```python<CR><CR>```<esc>ki",
                { desc = "Create a new code cell", silent = true }
            )
            vim.keymap.set(
                "n",
                "<localleader>cs",
                "i```\r\r```{}<left>",
                { desc = "Split code cell", silent = true, noremap = true }
            )
        end,
    },

    {
        "benlubas/molten-nvim",
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- vim.g.molten_cover_empty_lines = true
            -- vim.g.molten_comment_string = "# %%"

            -- vim.g.molten_auto_image_popup = true
            -- vim.g.molten_show_mimetype_debug = true
            vim.g.molten_auto_open_output = false
            vim.g.molten_image_provider = "image.nvim"
            -- vim.g.molten_output_show_more = true
            vim.g.molten_output_win_border = { "", "━", "", "" }
            vim.g.molten_output_win_max_height = 24
            -- vim.g.molten_output_virt_lines = true
            vim.g.molten_virt_text_output = true
            -- vim.g.molten_use_border_highlights = true
            -- vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_wrap_output = true
            vim.g.molten_tick_rate = 144

            vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
            vim.keymap.set("n", "<localleader>ir", function()
                vim.cmd("MoltenInit rust")
            end, { desc = "Initialize Molten for Rust", silent = true })

            vim.keymap.set("n", "<localleader>ip", function()
                local venv = os.getenv("VIRTUAL_ENV")
                if venv ~= nil then
                    -- load jupyter kernel with the name of project root dir
                    -- init kernel: `python -m ipykernel --user --name <kernelname>`
                    venv = string.match(venv, "/.+/(.+)/.+")
                    vim.cmd(("MoltenInit %s"):format(venv))
                else
                    vim.cmd("MoltenInit python3")
                end
            end, { desc = "Initialize Molten for python", silent = true, noremap = true })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MoltenInitPost",
                callback = function()
                    -- quarto code runner mappings
                    local r = require("quarto.runner")
                    vim.keymap.set("n", "<localleader>rc", r.run_cell, { desc = "run cell", silent = true })
                    vim.keymap.set("n", "<localleader>ra", r.run_above, { desc = "run cell and above", silent = true })
                    vim.keymap.set("n", "<localleader>rb", r.run_below, { desc = "run cell and below", silent = true })
                    vim.keymap.set("n", "<localleader>rl", r.run_line, { desc = "run line", silent = true })
                    vim.keymap.set("n", "<localleader>rA", r.run_all, { desc = "run all cells", silent = true })
                    vim.keymap.set("n", "<localleader>RA", function()
                        r.run_all(true)
                    end, { desc = "run all cells of all languages", silent = true })

                    -- setup some molten specific keybindings
                    vim.keymap.set(
                        { "v", "n" },
                        "<leader><leader>R",
                        "<Cmd>MoltenEvaluateVisual<CR>",
                        { desc = "Molten Evaluate visual in visual and normal mode", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>ro",
                        ":MoltenEvaluateOperator<CR>",
                        { desc = "evaluate operator ([r]un [o]perator)", silent = true }
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
                        "<localleader>os",
                        ":noautocmd MoltenEnterOutput<CR>",
                        { desc = "open output window", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>oh",
                        ":MoltenHideOutput<CR>",
                        { desc = "close output window", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>md",
                        ":MoltenDelete<CR>",
                        { desc = "delete Molten cell", silent = true }
                    )
                    local open = false
                    vim.keymap.set("n", "<localleader>ot", function()
                        open = not open
                        vim.fn.MoltenUpdateOption("auto_open_output", open)
                    end)

                    -- if we're in a python file, change the configuration a little
                    if vim.bo.filetype == "python" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
                    end
                end,
            })

            -- change the configuration when editing a python file
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*.py",
                callback = function(e)
                    if string.match(e.file, ".otter.") then
                        return
                    end
                    if require("molten.status").initialized() == "Molten" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
                    end
                end,
            })

            -- Undo those config changes when we go back to a markdown or quarto file
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.qmd", "*.md", "*.ipynb" },
                callback = function()
                    if require("molten.status").initialized() == "Molten" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", true)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
                    end
                end,
            })
        end,
    },
}
