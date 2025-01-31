local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<cr>", "Next buffer")
map("n", "<S-h>", "<cmd>bprevious<cr>", "Previous buffer")

-- Move to window with <ctrl> hjkl
map("n", "<C-h>", "<C-w>h", "Move left window")
map("n", "<C-j>", "<C-w>j", "Move lower window")
map("n", "<C-k>", "<C-w>k", "Move upper window")
map("n", "<C-l>", "<C-w>l", "Move right window")

-- Resize window with <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase window height")
map("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease window height")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")

-- Open/close vsplit
map("n", "<leader>-", "<cmd>vsplit<cr>", "Open vsplit")
map("n", "<leader>_", "<c-w>q", "Close vsplit")

-- Reselect visual area
map("v", "<", "<gv", "Shift left")
map("v", ">", ">gv", "Shift right")

-- Search
map({ "i", "n" }, "<esc>", "<cmd>nohlsearch<cr><esc>", "Escape and clear hlsearch")
map({ "n", "x" }, "gw", "*N", "Search word under cursor")

-- Move text up and down
map("x", "K", ":move '<-2<CR>gv-gv", "Move lines up")
map("x", "J", ":move '>+1<CR>gv-gv", "Move lines down")

-- Paste without yanking
map("v", "p", '"_dP', "Paste without yanking")

-- Delete current buffer and move to next
map("n", "<leader>bd", "<cmd>bn<cr><cmd>bd#<cr>", "Delete current buffer")

-- Toggle options
map("n", "<leader>or", "<cmd>set invrelativenumber<cr>", "Toggle relativenumber")
map("n", "<leader>os", "<cmd>set invspell<cr>", "Toggle spell")
map("n", "<leader>ow", "<cmd>set invwrap<cr>", "Toggle wrap")

-- Delete full word using Ctrl Backspace
map("i", "<C-H>", "<Esc>cvb", "Delete full word")

-- Clipboard
map({ "n", "v" }, "<leader>y", '"+y', "Copy selection to clipboard")
map({ "n", "v" }, "<leader>yy", '"+yy', "Copy line to clipboard")
-- map({ "n", "v" }, "<leader>Y", '"+yg_', "Copy selection to clipboard without newline")

map({ "n", "v" }, "<leader>p", '"+p', "Paste from clipboard")
map({ "n", "v" }, "<leader>P", '"+P', "Paste from clipboard")

map({"i"}, "<C-l>", "<Right>", "move to right in insert")

-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
    local path = filename .. ".ipynb"
    local file = io.open(path, "w")
    if file then
        file:write(default_notebook)
        file:close()
        vim.cmd("edit " .. path)
    else
        print("Error: Could not open new notebook file for writing.")
    end
end

vim.api.nvim_create_user_command("NewNotebook", function(opts)
    new_notebook(opts.args)
end, {
    nargs = 1,
    complete = "file",
})
