-- Completion engine
-- https://github.com/hrsh7th/nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- luasnip
    { "L3MON4D3/LuaSnip", version = "*", run = "make install_jsregexp" },
    -- completion plugins
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "kdheepak/cmp-latex-symbols",
    "saadparwaiz1/cmp_luasnip",
    -- pictograms
    "onsails/lspkind.nvim",
    -- jupyter
    "jmbuhr/otter.nvim"
  },
  opts = function()
    local cmp = require("cmp")
    return {
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = {
        -- ":help ins-completion"
        ["<c-p>"] = cmp.mapping.select_prev_item(),
        ["<c-n>"] = cmp.mapping.select_next_item(),
        ["<c-b>"] = cmp.mapping.scroll_docs(-4),
        ["<c-f>"] = cmp.mapping.scroll_docs(4),
        ["<c-d>"] = cmp.mapping.scroll_docs(-4),
        ["<c-u>"] = cmp.mapping.scroll_docs(4),
        ["<c-c>"] = cmp.mapping.complete(),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<c-y>"] = cmp.mapping.confirm({ select = true }),
      },
      formatting = {
        format = require("lspkind").cmp_format({
          with_text = true,
          menu = {
            nvim_lsp = "[LSP]",
            nvim_lua = "[LUA]",
            luasnip = "[SNIP]",
            latex_symbols = "[LATEX]",
            buffer = "[BUF]",
            path = "[PATH]",
            otter = "[OTTER]",
          },
        }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "otter" },
        { name = "luasnip" },
        { name = "latex_symbols" },
        { name = "buffer" },
        { name = "path" },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
    }
  end,
}
