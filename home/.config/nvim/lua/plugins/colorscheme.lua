-- Colorscheme base16
-- https://github.com/RRethy/nvim-base16

return {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
        -- require("base16-colorscheme").setup({
        --     -- code_style = {
        --     --     comments = "none",
        --     -- },
        --     -- transparent = true,
        -- })
        vim.cmd.colorscheme("base16-default-dark")
        vim.api.nvim_set_hl(0, "TSComment", { italic = false })
    end,
}
