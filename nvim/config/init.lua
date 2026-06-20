vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.incsearch = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.cmd('set clipboard^=unnamed,unnamedplus')

vim.g.mapleader = ";"
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap("i", "jk", "<Esc>", opts)
vim.api.nvim_set_keymap("n", "H", "0", opts)
vim.api.nvim_set_keymap("n", "L", "$", opts)
vim.api.nvim_set_keymap("n", "J", "10jzz", opts)
vim.api.nvim_set_keymap("n", "K", "10kzz", opts)
vim.api.nvim_set_keymap("n", "<C-h>", "7h", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "7l", opts)
vim.api.nvim_set_keymap("n", "w", "<C-w>", opts)
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<Cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>s", ":SymbolsOutline<Cr>", opts)

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- Required plugins based on your keymaps
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }
  }
  use 'simrat39/symbols-outline.nvim'
end)

-- Safely load plugins so Neovim doesn't crash if they aren't installed yet
local status_tree, nvim_tree = pcall(require, "nvim-tree")
if status_tree then
  nvim_tree.setup()
end

local status_outline, symbols_outline = pcall(require, "symbols-outline")
if status_outline then
  symbols_outline.setup()
end
