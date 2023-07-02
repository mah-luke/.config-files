-- Colorscheme OneDark
-- https://github.com/navarasu/onedark.nvim
-- TODO: replace with https://github.com/rebelot/kanagawa.nvim?

-- TODO: comments more contrast
-- TODO: background darker

return {
   "navarasu/onedark.nvim",
   lazy = false,
   priority = 1000,
   config = function()
      require('onedark').setup {
         style = 'darker',
         code_style = {
            comments = 'none'
         },
         transparent = true
      }
      vim.cmd.colorscheme("onedark")
   end,
}
