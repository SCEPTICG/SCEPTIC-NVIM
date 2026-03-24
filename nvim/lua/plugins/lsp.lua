return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("mason").setup()
        local mlp = require("mason-lspconfig")

        -- Aseguramos que se instalen automáticamente
        mlp.setup({
            ensure_installed = { "lua_ls", "pyright", "bashls" }
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require("lspconfig")

        -- Python
        lspconfig.pyright.setup({ capabilities = capabilities })

        -- Bash
        lspconfig.bashls.setup({ capabilities = capabilities })

        -- Lua (para tu propia config)
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        })
    end
}
