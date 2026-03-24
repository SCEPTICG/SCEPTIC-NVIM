return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- Usamos pcall para que si falla, no bloquee el resto de Neovim
        local status, ts = pcall(require, "nvim-treesitter.configs")
        if not status then return end
     
        ts.setup({
            ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "bash", "vim", "vimdoc" },
            highlight = { enable = true },
        })
    end
}
