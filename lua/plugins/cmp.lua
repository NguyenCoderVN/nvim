return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-emoji",

    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
    },

    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local win_opts = { border = "rounded" }

    local snippet_dir = vim.fn.stdpath("config") .. "/snippets"
    local cpp_file = snippet_dir .. "/cpp.json"
    vim.fn.mkdir(snippet_dir, "p")

    local cdn_url =
      "https://raw.githubusercontent.com/NguyenCoderVN/snippets/refs/heads/main/cpp.json"

    -- 1. Kiểm tra và xóa file cũ (Xóa đồng bộ, xong mới đi tiếp)
    if vim.fn.filereadable(cpp_file) == 1 then
      vim.fn.delete(cpp_file)
    end

    -- 2. Kích hoạt tiến trình tải file mới
    vim.fn.jobstart({ "curl", "-s", "-f", "-o", cpp_file, cdn_url }, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          -- 3. Chỉ nạp (lazy_load) khi curl tải file thành công
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = { snippet_dir },
          })
        else
          -- Tùy chọn: Báo lỗi nếu quá trình tải thất bại
          vim.notify(
            "Lỗi tải snippet C++ từ GitHub!",
            vim.log.levels.ERROR
          )
        end
      end,
    })
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      performance = { max_view_entries = 9 },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(win_opts),
        documentation = cmp.config.window.bordered(win_opts),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
            emoji = "[Emoji]",
          }
          local src = entry.source.name
          item.menu = menu_icon[src] or "[" .. src .. "]"
          return item
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp", max_item_count = 4, priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "nvim_lua", priority = 700 },
      }, {
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
        { name = "emoji" },
      }),
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
      }),
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.filetype("oil", { enabled = false })
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "buffer" },
      }),
    })
  end,
}
