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

        -- Navegar entre cambios (hunks). nav_hunk es la API estable actual.
        map("n", "]h", function()
          gs.nav_hunk("next")
        end, "Siguiente cambio de Git")
        map("n", "[h", function()
          gs.nav_hunk("prev")
        end, "Cambio de Git anterior")
        -- Acciones sobre cambios (prefijo <leader>g para no chocar con <leader>h = nohlsearch)
        map("n", "<leader>gs", gs.stage_hunk, "Stage del cambio")
        map("n", "<leader>gr", gs.reset_hunk, "Descartar el cambio")
        map("n", "<leader>gp", gs.preview_hunk, "Previsualizar el cambio")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "Blame de la linea")
      end,
    },
  },
}
