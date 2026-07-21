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

opt.background = "dark"

-- 1. Viền bo tròn cho cửa sổ Hover (hiện ra khi bấm K)
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

-- 2. Viền bo tròn cho cửa sổ Gợi ý chữ ký hàm (Signature Help)
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

-- 3. Viền bo tròn cho cửa sổ thông báo lỗi/cảnh báo (Diagnostics)
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

-- Ánh xạ các nhóm highlight từ Treesitter C++ sang nhóm màu chung của hệ thống
vim.api.nvim_set_hl(0, "@variable.cpp", { link = "@variable" })
vim.api.nvim_set_hl(0, "@function.cpp", { link = "@function" })
vim.api.nvim_set_hl(
  0,
  "@variable.builtin.cpp",
  { link = "@variable.builtin" }
)
