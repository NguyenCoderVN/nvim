return {
  "folke/which-key.nvim",
  -- Bỏ hẳn enabled = false đi bạn nhé
  cmd = "WhichKey", -- Chỉ khởi động khi bạn gõ :WhichKey trong Neovim
  opts = {
    preset = "modern",
    delay = 300,
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Find/Files" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Search" },
        { "<leader>u", group = "UI/Toggles" },
        { "g", group = "Goto/LSP" },
        { "<leader><space>", hidden = true },
      },
    },
  },
}
