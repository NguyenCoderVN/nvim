return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      cpp = { "clang-format" },
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      markdown = { "prettier" },
    },
    formatters = {
      ["clang-format"] = {
        prepend_args = { "-style={ColumnLimit: 70}" },
      },
      stylua = {
        prepend_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
          "--column-width",
          "75",
        },
      },
      prettier = {
        prepend_args = {
          "--print-width",
          "75",
          "--prose-wrap",
          "always",
        },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
