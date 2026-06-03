return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "bashls", "jsonls", "yamlls" },
      automatic_enable = true,
    },
    config = function(_, opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        pyright = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end

      require("mason-lspconfig").setup(opts)
    end,
  },
}
