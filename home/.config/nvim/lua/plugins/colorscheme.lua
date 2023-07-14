-- Colorscheme OneDark
-- https://github.com/navarasu/onedark.nvim
-- TODO: replace with https://github.com/rebelot/kanagawa.nvim?

-- TODO: comments more contrast

return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("onedark").setup({
            -- style = "darker",
            code_style = {
                comments = "none",
            },
            transparent = true,
            -- term_colors = true,
            highlights = {
                CursorLine = {
                    bg = "#1c1f24", --"#181a1f",
                },
            },
            -- colors = {
            --    grey = "red",
            -- },
        })
        vim.cmd.colorscheme("onedark")
        vim.api.nvim_set_hl(0, "MatchParen", { bg = "#24282f", undercurl = true })
    end,
}
