-- Configuracion de luacheck para una config de Neovim
std = "luajit"
globals = { "vim" }
-- Silenciamos avisos poco utiles para dotfiles
ignore = {
  "212", -- argumento sin usar
  "631", -- linea demasiado larga
}
