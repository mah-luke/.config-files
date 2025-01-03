-- Telescope
-- https://github.com/nvim-telescope/telescope.nvim

return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make", config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
        },
        cmd = "Telescope",
        -- TODO: add Keymaps for git using Telescope
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope List Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope Find Help" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope Find Keymaps" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Telescope Find Old Files" },
            { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Telescope [F]ind [C]ommands" },
            { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Telescop [F]ind [D]iagnostics" },
            {
                "<leader>fdf",
                function()
                    require("telescope.builtin").find_files({
                        prompt_title = "Find Dotfiles",
                        cwd = "~/.config-files",
                    })
                end,
                desc = "Find Dotfiles",
            },
            {
                "<leader>fs",
                "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                desc = "Telescope [F]ind dynamic workspace [S]ymbols",
            },
            { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope [F]ind [R]eferences" },
            -- Git
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            vim.api.nvim_set_keymap(
                "n",
                "<Leader>fhf",
                ':lua require"telescope.builtin".find_files({ hidden = true, no_ignore = true, file_ignore_patterns = {".*.git.*"} })<CR>',
                { noremap = true, silent = true }
            )
        end,
        opts = {
            defaults = {
                layout_config = { prompt_position = "top" },
                prompt_prefix = "> ",
                selection_caret = "> ",
                sorting_strategy = "ascending",
            },
            pickers = {
                find_files = {
                    find_command = { "fd", "--type", "f", "--follow", "--hidden" },
                },
            },
        },
    },
}
