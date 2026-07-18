-- SCEPTIC-NVIM: override del lado del explorador de archivos segun preferencias.
--
-- Ajusta la posicion de la ventana de neo-tree (el explorador de archivos que
-- usa LazyVim) al valor de prefs.explorer_side. Con el default "left" esto es
-- EXACTAMENTE lo que hace LazyVim de fabrica, asi que no cambia nada (capa
-- inerte en Fase 1).
--
-- Los opts se FUSIONAN con los de LazyVim (no los reemplazan), asi que solo
-- tocamos window.position y el resto de la config de neo-tree se conserva.
--
-- Validamos que explorer_side sea "left" o "right" antes de aplicarlo; si es
-- cualquier otra cosa (JSON raro), caemos a "left" para no romper neo-tree.

local prefs = require("sceptic.prefs")

local side = prefs.explorer_side
if side ~= "left" and side ~= "right" then
  side = "left"
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = side,
      },
    },
  },
}
