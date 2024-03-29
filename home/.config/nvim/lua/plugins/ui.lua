return {
    -- Statusbar
    -- https://github.com/nvim-lualine/lualine.nvim
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                component_separators = "|",
                section_separators = "",
            },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
                lualine_x = { "filetype" },
            },
            inactive_sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
            },
        },
    },

    -- Indentation guides
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        -- opts = {
        --     show_current_context = true,
        --     show_current_context_start = true,
        -- },
    },
}
