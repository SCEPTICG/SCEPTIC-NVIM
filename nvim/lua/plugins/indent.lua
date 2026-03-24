return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = { char = "▎" },
        scope = { enabled = true, show_start = true },
        -- Añade esta sección para excluir el Dashboard y otras ventanas
        exclude = {
            filetypes = {
                "dashboard",
                "help",
                "terminal",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
            },
        },
    },
}
