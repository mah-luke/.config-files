-- Colorscheme base16
-- https://github.com/RRethy/nvim-base16

local function update_hl(group, tbl)
    local old_hl = vim.api.nvim_get_hl_by_name(group, true)
    local new_hl = vim.tbl_extend("force", old_hl, tbl)
    vim.api.nvim_set_hl(0, group, new_hl)
end

return {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("base16-default-dark")
        update_hl("TSComment", { italic = false })
        -- update_hl("LspInlayHint", { italic = false })
        -- update_hl("TreesitterContext", { italic = false })
    end,
}
