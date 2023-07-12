-- https://github.com/folke/todo-comments.nvim
-- highlight TODO, etc.
-- Adds todo tree
-- TODO: add keybinds
--
-- Possible Keywords:
-- TODO: asdf
-- FIXME: asdf
-- BUG: asdf
-- NOTE: asdf
-- HACK: asdf
-- WARNING: asdf
-- PERF: asdf
-- TEST: asd

return {
   "folke/todo-comments.nvim",
   version = "*",
   dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
   cmd = { "TodoTrouble", "TodoTelescope" },
   event = { "BufReadPost", "BufNewFile" },
   config = true,
   -- stylua: ignore
   keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "todo: Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "todo: Previous todo comment" },
      { "<leader>tt", "<cmd>TodoTrouble<cr>", desc = "todo: Todo (Trouble)" },
      -- { "<leader>tT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "todo: Todo" },
      -- { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
   },
}
