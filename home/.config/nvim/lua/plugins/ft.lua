-- Plugins which are filetype specific.

return {
    {
        -- https://github.com/iamcco/markdown-preview.nvim
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        ft = "markdown",
        config = function()
            vim.keymap.set("n", "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview" })
        end,
    },
    -- {
    --     "OXY2DEV/markview.nvim",
    --     ft = "markdown",
    --     opts = {
    --         modes = { "n", "v", "i" },
    --         code_blocks = {
    --             enable = true,
    --             style = "language",
    --             position = "inline",
    --
    --             hl = "markdownCodeBlock",
    --
    --             min_width = 0,
    --             pad_char = " ",
    --             pad_amount = 0,
    --
    --             language_names = nil,
    --             name_hl = nil,
    --             language_direction = "left",
    --
    --             sign = true,
    --             sign_hl = nil,
    --         },
    --     },
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-tree/nvim-web-devicons",
    --     },
    -- },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        enabled = true,
        main = "render-markdown",
        name = "render-markdown", -- don't clash with other markdown.nvim plugin
        ft = { "markdown" },
        opts = {
            latex = {
                enabled = false,
                converter = "latex2text",
                render_modes = true,
                top_pad = 0,
                bottom_pad = 0,
                highlight = "RenderMarkdownMath",
            },
            win_options = {
                conceallevel = {
                    default = vim.api.nvim_get_option_value("conceallevel", {}),
                    rendered = 2,
                },
            },
            render_modes = true,
            code = {
                language_name = true,
                -- left_pad = 2,
                border = "thin", -- Used above code blocks for thin border
                above = "▄",
                -- Used below code blocks for thin border
                below = "▀",
                -- disable_background = { "python" },
                -- border = "thick",
            },
            checkbox = {
                custom = {
                    inprogress = { raw = "[/]", rendered = " ", highlight = "RenderMarkdownInProgress" },
                },
            },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        config = function(_, opts)
            render_markdown = require("render-markdown").setup(opts)
            local colors = Colors
            vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = colors.base08 })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = colors.base09 })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = colors.base0A })
            vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = colors.base0B })
            vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#121212" })
            -- vim.api.nvim_set_hl(0, "Normal", { bg = colors.base01 })
        end,
    },
    {
        -- https://github.com/lervag/vimtex
        -- pacman -S zathura xdotools
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "auxil",
                out_dir = "out",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                hooks = {},
                options = {
                    -- '-pdflua'
                },
                -- \   '-verbose',
                -- \   '-file-line-error',
                -- \   '-syn:
                -- \   '-interaction=nonstopmode',
                -- \ ],
                --
                --
            }
            local au_group = vim.api.nvim_create_augroup("init", {})
            -- vim.api.nvim_create_autocmd("CursorMoved", {
            --     pattern = "*",
            --     group = au_group,
            --     command = [[echo join(vimtex#syntax#stack(), ' -> ')]],
            -- })
            vim.api.nvim_create_autocmd("BufReadPost", {
                pattern = "*.md",
                group = au_group,
                command = [[set syntax=markdown]],
            })

            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_view_general_viewer = "zathura" -- :h vimtex-view-zathura
            -- vim.g.latex_view_general_options=shellescape("--synctex-forward" . '".exepath(v:progpath).' --servername '.v:servername.' +{%lline} {%ffile}"')
            --
        end,
    },

    -- {
    --     "jbyuki/nabla.nvim",
    --     opts = {},
    --     config = function(_, opts)
    --         require("nabla").enable_virt({ autogen = true, silent = false })
    --     end,
    -- },
}
