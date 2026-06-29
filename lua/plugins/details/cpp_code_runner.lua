return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      mode = "float",
      focus = true,
      startinsert = true,

      float = {
        close_key = "<ESC>",
        border = "rounded",
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
        border_hl = "FloatBorder",
        float_hl = "Normal",
        blend = 0,
      },

      filetype = {
        cpp = [[
          cd $dir && \
          g++ -O2 -std=c++17 $fileName -o $fileNameWithoutExt && \
          printf "\033[1;36mPlease input your value:\033[0m\n" && \
          result=$(./$fileNameWithoutExt) && \
          printf "\n\033[1;32mOutput:\n%s\033[0m\n" "$result" && \
          rm $fileNameWithoutExt
        ]],
      },
    })

    vim.api.nvim_create_autocmd("WinLeave", {
      pattern = "term://*",
      callback = function()
        local win = vim.api.nvim_get_current_win()
        local config = vim.api.nvim_win_get_config(win)

        if config.relative ~= "" then
          vim.schedule(function()
            if vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_win_close(win, true)
            end
          end)
        end
      end,
    })
  end,
}
