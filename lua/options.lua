local opt = vim.opt

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.wrap = false

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

--TSInstall bash c cpp css html javascript lua python query tsx typescript vim vimdoc
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "bash",
    "c",
    "cpp",
    "css",
    "html",
    "javascript",
    "lua",
    "python",
    "query",
    "sh",
    "tsx",
    "typescript",
    "typst",
    "vim",
    "vimdoc",
  },

  callback = function()
    local ok, ts = pcall(require, "vim.treesitter")
    if ok then
      vim.treesitter.start()
    end
  end,
})
