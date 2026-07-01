local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local dir = vim.fn.stdpath("config") .. "/snippets"
local f = dir .. "/cpp.json"
vim.fn.mkdir(dir, "p")

local url = "https://raw.githubusercontent.com/NguyenCoderVN/snippets/refs/heads/main/cpp.json?t="
  .. os.time()

vim.schedule(function()
  if vim.fn.filereadable(f) == 1 then
    vim.fn.delete(f)
  end
  vim.fn.jobstart({
    "curl",
    "-s",
    "-f",
    "-H",
    "Cache-Control: no-cache",
    "-o",
    f,
    url,
  })
end)
require("options")
require("keymaps")

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.details" },
  },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
})
