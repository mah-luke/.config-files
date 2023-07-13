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
    {
        -- https://github.com/lervag/vimtex
        -- pacman -S zathura xdotools
        "lervag/vimtex",
        ft = "tex",
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
    {
        -- https://github.com/goerz/jupytext.vim
        -- jupytext: render .ipynb as markdown
        "goerz/jupytext.vim",
        config = function()
            vim.g.jupytext_fmt = "py:percent"
        end,
        -- event = { "BufReadPost", "BufNewFile" }, -- TODO: optimize loading of jupytext
    },
}
