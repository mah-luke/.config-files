-- Plugins which are filetype specific.

return {
    {
        -- https://github.com/tridactyl/vim-tridactyl
        "tridactyl/vim-tridactyl",
        ft = "tridactyl",
    },
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
        "MeanderingProgrammer/markdown.nvim",
        main = "render-markdown",
        name = "render-markdown", -- don't clash with other markdown.nvim plugin
        opts = {
            code = {
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
        config = function()
            local colors = require("base16-colorscheme").colors
            vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = colors.base08 })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = colors.base09 })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = colors.base0A })
            vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = colors.base0B })
        end,
    },
    {
        -- https://github.com/lervag/vimtex
        -- pacman -S zathura xdotools
        "lervag/vimtex",
        ft = "tex",
        lazy = false,
        config = function()
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "aux",
                out_dir = "out",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                hooks = {},
                -- \ 'options' : [
                -- \   '-verbose',
                -- \   '-file-line-error',
                -- \   '-syn:
                -- \   '-interaction=nonstopmode',
                -- \ ],
            }
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_view_general_viewer = "zathura" -- :h vimtex-view-zathura
            -- vim.g.latex_view_general_options=shellescape("--synctex-forward" . '".exepath(v:progpath).' --servername '.v:servername.' +{%lline} {%ffile}"')
        end,
    },
}
