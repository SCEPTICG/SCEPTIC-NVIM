-- SCEPTIC-NVIM: opciones.
-- Este fichero lo carga LazyVim automaticamente (antes de lazy.nvim) y se
-- fusiona con las opciones por defecto de LazyVim.
--
-- Fase 1: lo dejamos practicamente vacio para heredar TODOS los defaults de
-- LazyVim (comportamiento de fabrica). El leader se fija aqui, como en el
-- starter oficial, para que sea correcto antes de que carguen los plugins.
--
-- NOTA: LazyVim tambien fija estos leaders por su cuenta; los dejamos explicitos
-- aqui por seguridad y para seguir el patron del starter.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Añade aqui tus opciones propias en el futuro, p. ej.:
-- vim.opt.relativenumber = true
