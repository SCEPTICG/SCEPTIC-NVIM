return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            -- Configuración visual
            view = {
                width = 30,
                side = "right", -- Lo querías a la derecha
            },
            renderer = {
                group_empty = true,
                indent_markers = {
                    enable = true, -- Las líneas que conectan carpetas
                },
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },
            -- Comportamiento de archivos
            update_focused_file = {
                enable = true,
                update_root = true,
            },
            filters = {
                dotfiles = false, -- Para ver archivos .bashrc, .zshrc, etc.
            },
            git = {
                ignore = false, -- Para ver archivos que están en .gitignore
            },
        })

        -- Atajo de teclado: Espacio + e para abrir/cerrar manualmente
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "Explorador de archivos" })
    end,
}
