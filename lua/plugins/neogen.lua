return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    snippet_engine = "luasnip",
    languages = {
      cpp = {
        template = {
          annotation_convention = "doxygen",
        },
      },
    },
  },
  keys = {
    {
      "<Leader>cg",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Annotations",
    },
  },
}
