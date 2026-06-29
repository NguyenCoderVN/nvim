return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "󰌵",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local servers = vim.tbl_map(function(p)
      return vim.fn.fnamemodify(p, ":t:r")
    end, vim.fn.globpath("lua/lsp_servers", "*.lua", 0, 1))

    for _, name in ipairs(servers) do
      local ok, config = pcall(require, "lsp_servers." .. name)
      if ok then
        config.capabilities = capabilities
        vim.lsp.config(name, config)
      else
        vim.notify("Error in load LSP config: " .. name, 4)
      end
    end
    vim.lsp.enable(servers)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        if vim.bo[bufnr].filetype == "oil" and client then
          vim.lsp.buf_detach_client(bufnr, client.id)
          return
        end

        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        end
        vim.keymap.set("n", "<leader>cc", vim.lsp.buf.code_action)
      end,
    })
  end,
}
