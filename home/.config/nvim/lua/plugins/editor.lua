return {

    -- keymaps for commenting
    -- https://github.com/numToStr/Comment.nvim
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },

    -- highlight uses of word under cursor
    -- https://github.com/RRethy/vim-illuminate
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("illuminate").configure({})
        end,
    },

    { "christoomey/vim-tmux-navigator" },
}
