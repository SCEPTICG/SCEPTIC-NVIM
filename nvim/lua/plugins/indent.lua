return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "|" },
      scope = { enabled = true },
      exclude = {
        filetypes = { "dashboard", "help", "terminal", "lazy", "mason", "toggleterm" },
      },
    },
  },
}
