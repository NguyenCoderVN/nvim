return {
  "stevearc/oil.nvim",
  dependencies = { "SirZenith/oil-vcs-status" },
  opts = {
    default_file_explorer = false,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name)
        return name == ".." or name == ".git"
      end,
    },
    win_options = { signcolumn = "number" },
    keymaps = { ["<C-s>"] = false, ["<C-h>"] = false, ["<C-t>"] = false },
  },
  keys = { { "-", "<cmd>Oil<cr>" } },
}
