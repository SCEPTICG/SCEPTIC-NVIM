return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Fijamos la rama clasica: la API require("nvim-treesitter.configs").setup(...)
    -- solo existe en "master". La rama "main" es la reescritura sin esa API.
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "bash", "json", "lua", "markdown", "python", "vim", "vimdoc", "yaml" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
