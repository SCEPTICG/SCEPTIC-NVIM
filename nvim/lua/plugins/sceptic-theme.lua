-- SCEPTIC-NVIM: override del tema segun preferencias.
--
-- Fija el colorscheme de LazyVim al valor de prefs.theme, pasandolo antes por
-- sceptic.theme.resolve() para VALIDARLO: si el tema del JSON no esta en el
-- catalogo conocido, cae a "tokyonight" y el arranque no se rompe.
--
-- Ademas declara aqui los plugins de los temas del catalogo que no vienen de
-- serie con LazyVim. Se declaran como los temas de LazyVim (lazy = true,
-- priority = 1000): lazy.nvim los instala y los carga cuando se aplica su
-- colorscheme (tanto al arrancar como con :ScepticTheme en caliente).
--
-- El comando :ScepticTheme (cambio en caliente + persistencia) se registra
-- desde config/autocmds.lua llamando a require("sceptic.theme").setup().

local prefs = require("sceptic.prefs")
local theme = require("sceptic.theme")

return {
  -- Temas del catalogo:
  --   * tokyonight ya viene con LazyVim, no hace falta declararlo.
  --   * catppuccin tambien lo incluye LazyVim; lo declaramos de forma explicita
  --     por claridad (declarar el mismo repo solo fusiona la spec, es inocuo).
  { "catppuccin/nvim", name = "catppuccin", lazy = true, priority = 1000 },
  --   * dracula NO viene de serie: lo añadimos nosotros.
  { "Mofiqul/dracula.nvim", lazy = true, priority = 1000 },

  {
    "LazyVim/LazyVim",
    opts = {
      -- resolve() garantiza un nombre valido (fallback a tokyonight).
      colorscheme = theme.resolve(prefs.theme),
    },
  },
}
