return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      markdown = { "markdownlint" },
    }

    local lint_augroup =
      vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd(
      { "BufReadPost", "BufWritePost", "InsertLeave" },
      {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      }
    )

    -- Keymap xem lỗi (Sử dụng lệnh mặc định của Neovim)
    vim.keymap.set("n", "<leader>ll", function()
      vim.diagnostic.open_float(nil, {
        scope = "line",
        source = "always",
        border = "rounded",
      })
    end, { desc = "Show line diagnostics" })
  end,
}
