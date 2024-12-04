return {
    -- git decorations
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                end

                -- stylua: ignore start
                map("n", "]g", gs.next_hunk, "GitSigns Next Hunk")
                map("n", "[g", gs.prev_hunk, "GitSigns Prev Hunk")
                -- map("n", "<leader>gl", gs.set_loclist, "GitSigns LocList")

                map('n', '<leader>gs', gs.stage_hunk, "GitSigns Stage Hunk")
                map('n', '<leader>gr', gs.reset_hunk, "GitSigns Reset Hunk")
                map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "GitSigns Stage Hunk Visual")
                map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "GitSigns Reset Hunk Visual")
                map('n', '<leader>gS', gs.stage_buffer, "GitSigns Stage Buffer")
                map('n', '<leader>gu', gs.undo_stage_hunk, "GitSigns Undo Stage Hunk")
                map('n', '<leader>gR', gs.reset_buffer, "GitSigns Reset Buffer")
                map('n', '<leader>gp', gs.preview_hunk, "GitSigns Preview Hunk")
                map('n', '<leader>gb', function() gs.blame_line{full=true} end, "GitSigns Blame Line")
                map('n', '<leader>gB', gs.blame, "GitSigns Blame Buffer")
                map('n', '<leader>gtb', gs.toggle_current_line_blame, "GitSigns Toggle Current Line Blame")
                map('n', '<leader>gd', gs.diffthis, "GitSigns Diff This")
                map('n', '<leader>gD', function() gs.diffthis('~') end, "GitSigns Diff This ~")
                map('n', '<leader>gtd', gs.toggle_deleted, "GitSigns Toggle Deleted")

                -- Text object
                -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                -- stylua: ingore end
            end,
            signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
            numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        },
    },
    -- git diff & merge
    -- https://github.com/sindrets/diffview.nvim
    {
        "sindrets/diffview.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- enhanced_diff_hl = true,
        },
        config = function(_, opts)
            diffview = require("diffview").setup(opts)
            vim.keymap.set("n", "<leader>gvo", ":DiffviewOpen<cr>", { desc = "Git DiffView open" })
            vim.keymap.set("n", "<leader>gvc", ":DiffviewClose<cr>", { desc = "Git DiffView close" })
            vim.keymap.set(
                "n",
                "<leader>gvb",
                ":DiffviewFileHistory %<cr>",
                { desc = "Git DiffView File History Buffer" }
            )
            vim.keymap.set(
                "n",
                "<leader>gvh",
                ":DiffviewFileHistory%<cr>",
                { desc = "Git DiffView File History Buffer" }
            )
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },

        opts = {},
    },
    {
        "ldelossa/gh.nvim",
        dependencies = {
            {
                "ldelossa/litee.nvim",
                config = function()
                    require("litee.lib").setup()
                end,
            },
        },
        config = function()
            require("litee.gh").setup()
        end,
    },
}
