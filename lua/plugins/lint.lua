return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      markdown = { "markdownlint" },
      cpp = { "cppcheck" },
    }

    local cppcheck = lint.linters.cppcheck
    table.insert(cppcheck.args, "--suppress=missingIncludeSystem")

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
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded",
      })
    end, { desc = "LSP Hover Documentation" })

    vim.keymap.set("n", "<leader>ll", function()
      vim.diagnostic.open_float(nil, {
        scope = "line",
        source = "always",
        border = "rounded",
      })
    end, { desc = "Show line diagnostics" })
  end,
}
