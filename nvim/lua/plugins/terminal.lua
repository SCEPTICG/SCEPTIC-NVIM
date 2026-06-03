return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<c-t>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Alternar terminal" },
    },
    opts = {
      size = 20,
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    },
  },
}
