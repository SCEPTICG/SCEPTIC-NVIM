-- SCEPTIC-NVIM: autocomandos.
-- Este fichero lo carga LazyVim automaticamente. Se añade a los autocmds por
-- defecto de LazyVim.
--
-- Fase 1: vacio a proposito para heredar el comportamiento de fabrica de LazyVim.
-- Añade aqui tus autocomandos propios en el futuro.

-- Fase 2A: registramos el comando :ScepticTheme (cambio de tema en caliente +
-- persistencia). La logica vive en lua/sceptic/theme.lua; aqui solo disparamos
-- el registro desde un fichero que LazyVim carga al arrancar.
require("sceptic.theme").setup()
