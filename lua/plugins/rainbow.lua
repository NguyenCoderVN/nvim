return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local rainbow = require("rainbow-delimiters")

    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow.strategy["global"],
        vim = rainbow.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      priority = {
        [""] = 110,
        lua = 210,
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }

    vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f7768e" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#e0af68" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#7aa2f7" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#ff9e64" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#9ece6a" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#bb9af7" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#7dcfff" })
  end,
}
