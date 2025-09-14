-- ~/.config/nvim/init.lua

-- Set editor options
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Bootstrap and setup lazy.nvim
-- This line assumes your lazy config is in ~/.config/nvim/lua/config/lazy.lua
require("config.lazy") 

-- Tell Neovim to use the colorscheme
vim.cmd.colorscheme "tokyonight-moon"

-- Treesitter Config
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "yaml"},
  highlight = { enable = true},
  indent = { enable = true},

})

