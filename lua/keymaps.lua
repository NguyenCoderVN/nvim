local map = vim.keymap.set
local A = { "n", "v", "i", "t", "s" }
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      timeout = 1000,
    })
  end,
})

map(A, "<leader>q", "<cmd>silent! wa! | qa!<CR>")
map(A, "<leader>ss", "<cmd>source %<CR>")
map(A, "<C-s>", function()
  vim.api.nvim_input("<Esc>")
  local win, cur =
    vim.api.nvim_get_current_win(), vim.api.nvim_win_get_cursor(0)
  vim.schedule(function()
    vim.cmd("silent! write!")
    pcall(vim.api.nvim_win_set_cursor, win, cur)
    if vim.bo.filetype ~= "oil" then
      vim.notify("Saved!", 2)
    end
  end)
end, { desc = "Save" })

map("n", "gf", "<cmd>edit <cfile><CR>", { desc = "Edit file" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })
map("i", "<A-o>", "<C-o>o", { desc = "Insert line below" })

-- Selection
map("n", "<C-a>", "<Esc>ggVG", { desc = "Select whole file" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select whole file" })
map("v", "<C-a>", "<Esc>ggVG", { desc = "Select whole file" })
map({ "i", "n", "v" }, "<A-v>", "<Esc>V", { desc = "Select 1line" })

-- Copy
map("v", "<C-c>", '"+y<Esc>', { desc = "Copy reg+" })
map("n", "<C-c>", '"+yy', { desc = "Copy 1line to reg+" })
map("i", "<C-c>", '<C-o>"+yy', { desc = "Copy 1line to reg+" })
map("n", "<C-y>", "yy", { desc = "Yank 1line" })
map("v", "<C-y>", "<Esc>yy", { desc = "Yank 1line" })
map("i", "<C-y>", "<Esc>yyi", { desc = "Yank 1line" })

-- Paste from yank A-p
-- Paste from system Shift Insert
map("n", "<A-d>", '"1p', { desc = "Paste delete reg1" })
map("v", "<A-d>", '"1p', { desc = "Paste delete reg1" })
map("i", "<A-d>", "<C-r>1", { desc = "Paste delete reg1" })

-- Delete
map("i", "<C-d>", "<C-[>ddI", { desc = "Delete one line" })
map("n", "<leader>a", ":%d<CR>", { desc = "Delete all" })

-- Comment
map("n", "<A-/>", "gcc", { remap = true, desc = "Comment" })
map("i", "<A-/>", "<Esc>gccI", { remap = true, desc = "Comment" })
map("v", "<A-/>", "gc", { remap = true, desc = "Comment selection" })
