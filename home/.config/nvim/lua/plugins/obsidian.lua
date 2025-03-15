return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        ui = { enable = false },
        -- ui = {
        --     enable = true,
        --     update_debounce = 200,
        --     max_file_length = 5000,
        --     checkboxes = {
        --         [" "] = { char = "○", hl_group = "ObsidianTodo" },
        --         ["x"] = { char = "●", hl_group = "ObsidianDone" },
        --         [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        --         ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        --         ["!"] = { char = "", hl_group = "ObsidianImportant" },
        --         ["/"] = { char = "◐", hl_group = "ObsidianRightArrow" },
        --         ["<"] = { char = "⏳", hl_group = "ObsidianRightArrow" },
        --     },
        -- },
        workspaces = {
            {
                name = "main",
                path = "~/Documents/notes",
            },
            -- {
            --     name = "no-vault",
            --     path = function()
            --         -- alternatively use the CWD:
            --         -- return assert(vim.fn.getcwd())
            --         return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
            --     end,
            --     overrides = {
            --         notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
            --         new_notes_location = "current_dir",
            --         templates = {
            --             folder = vim.NIL,
            --         },
            --         disable_frontmatter = true,
            --     },
            -- },
        },
        new_notes_location = "0_inbox",
        daily_notes = {
            folder = "5_daily",
            default_tags = { "daily" },
            template = "template/Daily.md",
        },
        completion = {
            min_chars = 2,
        },
        markdown_link_func = function (opts)
            return require("obsidian.util").markdown_link(opts)
        end,
        preferred_link_style = "markdown", -- "markdown" or "wiki"
        templates = {
            folder = "template",
        },
        open_app_foreground = false,
        picker = {
            name = "telescope.nvim",
            note_mappings = {
                new = "<C-x>",
                insert_link = "C-l>",
            },
            tag_mappings = {
                tag_note = "<C-x>",
                insert_tag = "<C-l>",
            },
        },
        attachments = {
            img_folder = "graphic",
        },
    },
}
