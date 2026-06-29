return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "fedepujol/move.nvim",
    keys = {
      { "<A-j>", "<Cmd>MoveLine(1)<CR>", mode = { "n", "i" } },
      { "<A-k>", "<Cmd>MoveLine(-1)<CR>", mode = { "n", "i" } },
    },
    opts = { line = { indent = true }, block = { indent = true } },
  },

  -- Statusline configuration
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
      "SirZenith/oil-vcs-status",
    },
    opts = {
      options = {
        theme = "dracula",
      },
      sections = {
        lualine_x = { "filetype" },
        lualine_y = {},
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
