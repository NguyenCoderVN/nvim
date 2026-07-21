return {
  "jmbuhr/otter.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    lsp = {
      hover = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
      diagnostic_update_events = { "BufWritePost" },
    },
    buffers = {
      set_filetype = false,
      write_to_disk = false,
    },
  },
  config = function(_, opts)
    local otter = require("otter")
    otter.setup(opts)

    -- Tự động kích hoạt cho các file Norg và Markdown
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "norg", "markdown" },
      callback = function()
        -- Danh sách ngôn ngữ bạn muốn nhúng (LSP phải được cài sẵn trên máy)
        local languages = { "cpp", "python", "lua", "bash", "sql" }
        otter.activate(languages, true, true, nil)
      end,
    })
  end,
}
