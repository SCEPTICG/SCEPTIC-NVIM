return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view = {
        width = 32,
        side = "right",
      },
      renderer = {
        group_empty = true,
        indent_markers = { enable = true },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
    },
  },
}
