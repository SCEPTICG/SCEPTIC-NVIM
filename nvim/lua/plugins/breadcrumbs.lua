return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- Para resaltar la estructura
        'nvim-tree/nvim-web-devicons'      -- Para los iconos
    },
    config = function()
        require('lspsaga').setup({
            -- Configuración de los Breadcrumbs (Winbar)
            symbol_in_winbar = {
                enable = true,
                separator = " › ",
                hide_keyword = true,
                show_file = true,
                folder_level = 2,
            },
            -- Mejoras visuales extras de Lspsaga
            lightbulb = { enable = false }, -- Desactivamos el foco si te molesta
            ui = {
                border = 'rounded',
                devicon = true,
            },
        })

        -- Atajos rápidos para navegar por el código usando Lspsaga
        local keymap = vim.keymap
        keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { desc = "LSP Finder" })
        keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Documentación flotante" })
        keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Acciones de código" })
    end
}
