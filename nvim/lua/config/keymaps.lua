-- SCEPTIC-NVIM: keymaps.
-- Este fichero lo carga LazyVim automaticamente. Se añade a los keymaps por
-- defecto de LazyVim (que ya remapea j/k a gj/gk, etc.).
--
-- Preferencia "movement":
--   * "hjkl" (default o cualquier otro valor): NO tocamos nada. Se hereda el
--     comportamiento de fabrica de LazyVim.
--   * "jklñ": disposicion pensada para teclado ISO español, moviendo el bloque
--     de navegacion una tecla a la derecha (fila natural de la mano derecha):
--         j = izquierda   (como la h nativa)
--         k = arriba
--         l = abajo
--         ñ = derecha     (como la l nativa)
--         h = deshabilitada
--
-- OJO: es un remapeo INVASIVO. Todos los mapeos son NO recursivos (noremap, que
-- es el valor por defecto de vim.keymap.set), de modo que el lado derecho SIEMPRE
-- se interpreta con el significado NATIVO de la tecla, no con nuestros remapeos.
-- Asi evitamos cualquier recursion: p. ej. "j" -> "h" usa la h nativa (izquierda),
-- aunque nosotros hayamos deshabilitado la tecla fisica h.

local prefs = require("sceptic.prefs")

if prefs.movement == "jklñ" then
  local opts = { silent = true }

  -- Horizontales (n = normal, x = visual, o = operator-pending):
  --   j -> h (izquierda), ñ -> l (derecha). Nativas, el count funciona solo.
  vim.keymap.set(
    { "n", "x", "o" },
    "j",
    "h",
    vim.tbl_extend("force", opts, { desc = "Izquierda (jklñ)" })
  )
  vim.keymap.set(
    { "n", "x", "o" },
    "ñ",
    "l",
    vim.tbl_extend("force", opts, { desc = "Derecha (jklñ)" })
  )

  -- Verticales con comportamiento de "linea visual" cuando NO hay count, igual
  -- que hace LazyVim con j/k (gk/gj). Solo en normal y visual (n, x):
  --   k = arriba  (gk sin count),  l = abajo (gj sin count).
  vim.keymap.set(
    { "n", "x" },
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true, desc = "Arriba (jklñ)" }
  )
  vim.keymap.set(
    { "n", "x" },
    "l",
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true, desc = "Abajo (jklñ)" }
  )

  -- En operator-pending (o) usamos las verticales NATIVAS (k arriba, j abajo),
  -- igual que LazyVim, que tampoco aplica gk/gj en modo operador. Asi movimientos
  -- como "borrar hacia arriba" con el nuevo layout se comportan de forma predecible.
  vim.keymap.set(
    "o",
    "k",
    "k",
    vim.tbl_extend("force", opts, { desc = "Arriba (jklñ, operador)" })
  )
  vim.keymap.set("o", "l", "j", vim.tbl_extend("force", opts, { desc = "Abajo (jklñ, operador)" }))

  -- Deshabilitamos la h fisica (la izquierda vive ahora en j).
  vim.keymap.set(
    { "n", "x", "o" },
    "h",
    "<Nop>",
    vim.tbl_extend("force", opts, { desc = "h deshabilitada (jklñ)" })
  )
end
