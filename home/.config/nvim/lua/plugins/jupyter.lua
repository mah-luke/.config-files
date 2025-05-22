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
        build = false,
        opts = {
            enabled = false,
            backend = "kitty", -- whatever backend you would like to use
            processor = "magick_cli",
            max_width = 1000,
            max_height = 1500,
            max_height_window_percentage = 100,
            max_width_window_percentage = 100,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            tmux_show_only_in_active_window = true,

            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    -- download_remote_images = true,
                    only_render_image_at_cursor = true,
                    floating_windows = true,
                    filetypes = { "markdown", "quarto", "rmd" }, -- markdown extensions (ie. quarto) can go here
                },
            },
        },
    },
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
        config = function(_, config)
            local jupytext = require("jupytext")
            jupytext.setup(config)

            vim.keymap.set(
                "n",
                "<localleader>cn",
                [[i{
                 "cells": [
                  {
                   "cell_type": "markdown",
                   "id": "eac18b0c",
                   "metadata": {
                    "lines_to_next_cell": 0
                   },
                   "source": []
                  },
                  {
                   "cell_type": "code",
                   "execution_count": null,
                   "id": "073a95f5",
                   "metadata": {},
                   "outputs": [],
                   "source": [
                    "print(\"Hello World\")"
                   ]
                  }
                 ],
                 "metadata": {
                  "colab": {
                   "provenance": [],
                   "toc_visible": true
                  },
                  "kernelspec": {
                   "display_name": "Python 3 (ipykernel)",
                   "language": "python",
                   "name": "python3"
                  },
                  "language_info": {
                   "codemirror_mode": {
                    "name": "ipython",
                    "version": 3
                   },
                   "file_extension": ".py",
                   "mimetype": "text/x-python",
                   "name": "python",
                   "nbconvert_exporter": "python",
                   "pygments_lexer": "ipython3",
                   "version": "3.10.10"
                  }
                 },
                 "nbformat": 4,
                 "nbformat_minor": 4
                }]],
                { desc = "Create a new code cell", silent = true }
            )
        end,
    },
    {
        "jmbuhr/otter.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        ft = { "quarto", "markdown", "rmd" },
        config = function(_, opts)
            local otter = require("otter")
            otter.setup(opts)
        end,
        opts = {
            handle_leading_whitespace = true,
            lsp = {
                root_dir = function(_, bufnr)
                    return vim.fs.root(bufnr or 0, {
                        ".git",
                        "_quarto.yml",
                        "package.json",
                    }) or vim.fn.getcwd(0)
                end,
                -- enabled = true,
                -- hover = { border = "none" },
                diagnostic_update_events = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
            },
            -- buffers = {
            --   set_filetype = true,
            --   write_to_disk = true,
            -- },
            verbose = false,
        },
    },
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
            "benlubas/molten-nvim",
            -- "nvim-cmp",
            "saghen/blink.cmp",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            "nvimtools/hydra.nvim",
        },
        ft = { "quarto", "markdown", "rmd" },
        config = function()
            local quarto = require("quarto")
            quarto.setup({
                lspFeatures = {
                    languages = { "python", "rust", "lua", "r" },
                    chunks = "all", -- 'curly' or 'all'
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
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

            vim.g.molten_auto_image_popup = false
            -- vim.g.molten_show_mimetype_debug = true
            vim.g.molten_auto_open_output = false
            vim.g.molten_image_provider = "image.nvim"
            -- vim.g.molten_output_show_more = true
            vim.g.molten_image_location = "float"
            --
            vim.g.molten_output_win_border = { "", "━", "", "" }
            vim.g.molten_output_win_max_height = 32
            -- vim.g.molten_output_virt_lines = true
            vim.g.molten_virt_text_output = true
            vim.g.molten_use_border_highlights = true
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_wrap_output = true
            vim.g.molten_tick_rate = 144

            vim.api.nvim_set_hl(0, "MoltenCell", { bg = "" })

            vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
            vim.keymap.set("n", "<localleader>iR", ":MoltenInit ir<CR>", { desc = "Initialize Molten for R", silent = true })
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

            -- automatically import output chunks from a jupyter notebook
            -- tries to find a kernel that matches the kernel in the jupyter notebook
            -- falls back to a kernel that matches the name of the active venv (if any)
            local imb = function(e) -- init molten buffer
                vim.schedule(function()
                    local kernels = vim.fn.MoltenAvailableKernels()
                    -- local try_kernel_name = function()
                    --     local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
                    --     return metadata.kernelspec.name
                    -- end
                    -- local ok, kernel_name = pcall(try_kernel_name)
                    -- if not ok or not vim.tbl_contains(kernels, kernel_name) then
                    --     kernel_name = nil
                    --     local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
                    --     if venv ~= nil then
                    --         kernel_name = string.match(venv, "/.+/(.+)")
                    --     end
                    -- end
                    --

                    local venv = os.getenv("VIRTUAL_ENV")
                    local kernel_name = nil
                    if venv ~= nil then
                        kernel_name = string.match(venv, "/.+/(.+)/.+")
                    end
                    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
                        vim.cmd(("MoltenInit %s"):format(kernel_name))
                    end
                    vim.cmd("MoltenImportOutput")
                end)
            end

            -- automatically import output chunks from a jupyter notebook
            vim.api.nvim_create_autocmd("BufAdd", {
                pattern = { "*.ipynb" },
                callback = imb,
            })

            -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.ipynb" },
                callback = function(e)
                    if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
                        imb(e)
                    end
                end,
            })

            -- automatically export output chunks to a jupyter notebook on write
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.ipynb" },
                callback = function()
                    if require("molten.status").initialized() == "Molten" then
                        vim.cmd("MoltenExportOutput!")
                    end
                end,
            })
        end,
    },
}
