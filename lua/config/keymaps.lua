-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = LazyVim.safe_keymap_set

-- Custom Keymap for Launching Terminal
local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end

map("n", "<leader>tT", lazyterm, { desc = "Terminal (Root Dir)" })
map("n", "<leader>tt", function()
  LazyVim.terminal()
end, { desc = "Terminal (cwd)" })
