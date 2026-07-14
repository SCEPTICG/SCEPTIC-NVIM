return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navegar entre cambios (hunks)
        map("n", "]h", gs.next_hunk, "Siguiente cambio de Git")
        map("n", "[h", gs.prev_hunk, "Cambio de Git anterior")
        -- Acciones sobre cambios
        map("n", "<leader>hs", gs.stage_hunk, "Stage del cambio")
        map("n", "<leader>hr", gs.reset_hunk, "Descartar el cambio")
        map("n", "<leader>hp", gs.preview_hunk, "Previsualizar el cambio")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame de la linea")
      end,
    },
  },
}
