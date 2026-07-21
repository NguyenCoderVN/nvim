return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    -- Cấu hình để plugin tự động nạp cho cả norg và markdown
    ft = { "markdown", "norg" },
    opts = {
      -- Cho phép plugin nhận diện norg
      filetypes = { "markdown", "norg" },
      -- Cấu hình bảng
      table = {
        enabled = true,
        border = "rounded",
        alignment = "center",
      },
      latex = { enabled = false },
      yaml = { enabled = false },
    },
  },
}
