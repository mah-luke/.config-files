require("quarto").activate()

vim.api.nvim_create_user_command("", function() end, {})
local b = vim.api.nvim_get_current_buf()
local function set(lhs, rhs, desc)
    vim.api.nvim_buf_set_keymap(b, "n", lhs, rhs, { silent = true, noremap = true, desc = desc })
end

set("gd", ":lua require'otter'.ask_definition()<cr>", "[g]o to [d]efinition")
set("gt", ":lua require'otter'.ask_type_definition()<cr>", "[g]o to [t]ype definition")
set("K", ":lua require'otter'.ask_hover()<cr>", "hover documentation")
set("<leader>rn", ":lua require'otter'.ask_rename()<cr>", "[r]e[n]ame")
set("gr", ":lua require'otter'.ask_references()<cr>", "[g]o to [r]eferences")
set("gs", ":lua require'otter'.ask_document_symbols()<cr>", "[g]o to [s]ymbols")
set("<leader>lf", ":lua require'otter'.ask_format()<cr>", "[l]sp [f]ormat")
