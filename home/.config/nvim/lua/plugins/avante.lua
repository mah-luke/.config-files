return {
    -- Required dependencies
    { "MunifTanjim/nui.nvim", lazy = true },

    -- Main avante.nvim plugin
    {
        "yetone/avante.nvim",
        build = vim.fn.has("win32") ~= 0
                and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        event = "VeryLazy",
        opts = {
            provider = "copilot", -- Use your existing copilot setup
            selection = {
                hint_display = "none",
            },
            behaviour = {
                auto_set_keymaps = false, -- LazyVim disables this to avoid conflicts
                auto_approve_tool_permissions = false, -- Ask before each tool call
            },
        },
        cmd = {
            "AvanteAsk",
            "AvanteBuild",
            "AvanteChat",
            "AvanteClear",
            "AvanteEdit",
            "AvanteFocus",
            "AvanteHistory",
            "AvanteModels",
            "AvanteRefresh",
            "AvanteShowRepoMap",
            "AvanteStop",
            "AvanteSwitchProvider",
            "AvanteToggle",
        },
        keys = {
            { "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "Ask Avante" },
            { "<leader>ac", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
            { "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Edit Avante" },
            { "<leader>af", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
            { "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante History" },
            { "<leader>am", "<cmd>AvanteModels<CR>", desc = "Select Avante Model" },
            { "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat" },
            { "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider" },
            { "<leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante" },
            { "<leader>as", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
            { "<leader>at", "<cmd>AvanteToggle<CR>", desc = "Toggle Avante" },
        },
        dependencies = {
            "zbirenbaum/copilot.lua", -- Already in your setup
            "Kaiser-Yang/blink-cmp-avante", -- blink.cmp integration for avante
        },
    },

    -- Optional: Image pasting support
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        optional = true,
        opts = {
            -- recommended settings
            default = {
                embed_image_as_base64 = false,
                prompt_for_file_name = false,
                drag_and_drop = {
                    insert_mode = true,
                },
                -- required for Windows users
                use_absolute_path = true,
            },
        },
    },

    -- Optional: Enhanced markdown rendering for Avante
    {
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
}