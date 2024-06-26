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
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
        },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope List Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope Find Help" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope Find Keymaps" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Telescope Find Old Files" },
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
        },
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
