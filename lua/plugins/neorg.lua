return {
  "nvim-neorg/neorg",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.integrations.treesitter"] = {},
      ["core.esupports.hop"] = {}, -- Bắt buộc để nhận diện vùng dữ liệu
      ["core.promo"] = {}, -- Module quản lý thao tác macro/bake
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/notes",
            cpp = "~/cpp",
            cyper = "~/cyper",
          },
          defaults_workspace = "notes",
        },
      },
      ["core.concealer"] = {
        config = {
          icon_preset = "varied",
        },
      },
      ["core.qol.todo_items"] = {},
    },
  },
}
