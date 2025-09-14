-- ~/.config/nvim/lua/plugins.lua

return {
  -- Tokyo Night Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Yazi File Manager
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<C-y>",
        function()
          require("yazi").yazi()
        end,
        mode = { "n", "v" },
        desc = "Open yazi at the current file",
      },
      {
        "<leader>cw",
        function()
          require("yazi").yazi(nil, { cwd = vim.fn.getcwd() })
        end,
        desc = "Open yazi in nvim's working directory",
      },
      {
        "<c-up>",
        function()
          require("yazi").toggle()
        end,
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  -- Tree Sitter
  { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },

  -- Neo-tree File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,
    config = function()
      vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
      vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
    end,
  },
}
