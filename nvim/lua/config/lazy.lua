-- SCEPTIC-NVIM: bootstrap de lazy.nvim y arranque de LazyVim.
-- Patron oficial del starter de LazyVim, con un unico añadido propio:
-- leemos las preferencias y añadimos los imports de "extras" que se pidan.

-- Bootstrap: si no existe lazy.nvim, lo clonamos.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Capa de preferencias SCEPTIC: leemos la tabla de prefs (nunca falla).
local prefs = require("sceptic.prefs")

-- Spec base identica a la del starter de LazyVim.
local spec = {
  -- añade LazyVim y sus plugins base
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  -- importa/anula plugins propios (todo lo de lua/plugins/)
  { import = "plugins" },
}

-- Extras segun preferencias.
-- prefs.extras es una lista de ids de extras de LazyVim (p. ej. "lang.python",
-- "coding.copilot"). Con la lista vacia por defecto, esto NO añade nada, asi que
-- el comportamiento es identico a LazyVim de fabrica.
-- Fase 2/3: el menu TUI rellenara esta lista; aqui solo la recorremos.
for _, extra in ipairs(prefs.extras or {}) do
  table.insert(spec, { import = "lazyvim.plugins.extras." .. extra })
end

require("lazy").setup({
  spec = spec,
  defaults = {
    -- Con esto, los plugins propios se cargan al inicio (lazy solo para los de LazyVim).
    lazy = false,
    -- Se recomienda fijar version = "*" para instalar la ultima version estable
    -- de los plugins que la publiquen. Por defecto false para seguir HEAD.
    version = false,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- comprueba actualizaciones de plugins periodicamente
    notify = false, -- sin notificaciones
  },
  performance = {
    rtp = {
      -- deshabilita algunos plugins de rtp que no usamos
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
