-- SCEPTIC-NVIM: override del tema segun preferencias.
--
-- Fija el colorscheme de LazyVim al valor de prefs.theme. Con el default
-- "tokyonight" esto es EXACTAMENTE lo que hace LazyVim de fabrica, asi que
-- no cambia nada (capa inerte en Fase 1).
--
-- LazyVim ya incluye tokyonight y catppuccin como dependencias, por lo que esos
-- temas funcionan sin añadir nada.
--
-- Fase 2: cuando prefs.theme sea otro tema (p. ej. "gruvbox", "kanagawa"...),
-- aqui habra que:
--   1) Añadir a este spec (o a un modulo aparte) el plugin del tema.
--   2) Mapear, si hace falta, el nombre de la preferencia al nombre real del
--      colorscheme.
-- De momento solo pasamos el valor tal cual.

local prefs = require("sceptic.prefs")

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = prefs.theme,
    },
  },
}
