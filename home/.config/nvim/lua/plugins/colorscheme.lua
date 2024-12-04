-- Colorscheme base16
-- https://github.com/RRethy/nvim-base16
-- for color values refer to https://base16.netlify.app/previews/base16-default-dark.html

local function update_hl(group, tbl)
    local old_hl = vim.api.nvim_get_hl_by_name(group, true)
    local new_hl = vim.tbl_extend("force", old_hl, tbl)
    vim.api.nvim_set_hl(0, group, new_hl)
end

-- return {
--     "RRethy/nvim-base16",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd.colorscheme("base16-default-dark")
--         update_hl("TSComment", { italic = false })
--         -- update_hl("LspInlayHint", { italic = false })
--         -- update_hl("TreesitterContext", { italic = false })
--     end,
-- }
--
Colors = {
    base00 = "#181818",
    base01 = "#282828",
    base02 = "#383838",
    base03 = "#585858",
    base04 = "#b8b8b8",
    base05 = "#d8d8d8",
    base06 = "#e8e8e8",
    base07 = "#f8f8f8",
    base08 = "#ab4642",
    base09 = "#dc9656",
    base0A = "#f7ca88",
    base0B = "#a1b56c",
    base0C = "#86c1b9",
    base0D = "#7cafc2",
    base0E = "#ba8baf",
    base0F = "#a16946",
}
return {
    "echasnovski/mini.base16",
    version = "*",
    opts = {
        plugins = { default = true },
        use_cterm = false,
    },
    config = function(_, opts)
        opts.palette = Colors
        require("mini.base16").setup(opts)
        local default_text = Colors.base00
        -- TODO: find good defaults for diff
        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = Colors.base09 })
        -- vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#242918" })
        -- vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#331514" })
        -- vim.api.nvim_set_hl(0, "DiffChange", { bg = "#10171a" })
        -- vim.api.nvim_set_hl(0, "DiffText", { bg = "#31454d" })
        vim.api.nvim_set_hl(0, "DiffAdd", { fg = default_text, bg = Colors.base0B })
        vim.api.nvim_set_hl(0, "DiffDelete", { fg = default_text, bg = Colors.base08 })
        vim.api.nvim_set_hl(0, "DiffChange", { fg = default_text, bg = Colors.base03 })
        vim.api.nvim_set_hl(0, "DiffText", { fg = default_text, bg = Colors.base0D })
    end,
}
