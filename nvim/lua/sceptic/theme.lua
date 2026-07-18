-- SCEPTIC-NVIM: logica del tema (catalogo, validacion y comando :ScepticTheme).
--
-- Aqui vive TODO lo relacionado con la preferencia "theme":
--   * El catalogo de temas conocidos.
--   * La validacion/resolucion de un nombre de tema (con fallback seguro).
--   * El comando de usuario :ScepticTheme para cambiar de tema en caliente y
--     persistir la eleccion en sceptic-prefs.json.
--
-- El plugin del tema (lua/plugins/sceptic-theme.lua) usa M.resolve() para fijar
-- el colorscheme al arrancar, y config/autocmds.lua llama a M.setup() para
-- registrar el comando.

local M = {}

-- Catalogo de temas conocidos. La cadena es a la vez el nombre que se guarda en
-- sceptic-prefs.json Y el nombre real del colorscheme de Neovim (coinciden):
--   * tokyonight  -> viene de serie con LazyVim.
--   * catppuccin  -> plugin catppuccin/nvim (LazyVim ya lo incluye; lo declaramos igual).
--   * dracula     -> plugin Mofiqul/dracula.nvim.
M.catalog = { "tokyonight", "catppuccin", "dracula" }

-- ¿Es `name` un tema conocido del catalogo?
function M.is_valid(name)
  for _, t in ipairs(M.catalog) do
    if t == name then
      return true
    end
  end
  return false
end

-- Devuelve un nombre de tema SIEMPRE valido: el pedido si esta en el catalogo,
-- o "tokyonight" como fallback seguro (asi un JSON con un tema raro no rompe el
-- arranque ni deja a Neovim sin colorscheme).
function M.resolve(name)
  if M.is_valid(name) then
    return name
  end
  return "tokyonight"
end

-- Aplica un tema al vuelo (colorscheme) y, si funciona, lo persiste en el JSON.
local function apply_and_persist(name)
  -- El colorscheme puede fallar si el plugin del tema no esta instalado; lo
  -- envolvemos en pcall para avisar sin romper.
  local ok = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.notify("SCEPTIC: no se pudo aplicar el tema '" .. name .. "'", vim.log.levels.ERROR)
    return
  end

  -- Persistimos la eleccion (prefs.set ya es fallo seguro).
  local persisted = require("sceptic.prefs").set("theme", name)
  if persisted then
    vim.notify("SCEPTIC: tema '" .. name .. "' aplicado y guardado", vim.log.levels.INFO)
  else
    vim.notify("SCEPTIC: tema '" .. name .. "' aplicado (no se pudo guardar)", vim.log.levels.WARN)
  end
end

-- Registra el comando :ScepticTheme.
--   :ScepticTheme            -> menu vim.ui.select con el catalogo.
--   :ScepticTheme dracula    -> aplica y persiste ese tema (si es valido).
function M.setup()
  vim.api.nvim_create_user_command("ScepticTheme", function(opts)
    local arg = vim.trim(opts.args or "")

    if arg == "" then
      -- Sin argumento: menu interactivo.
      vim.ui.select(M.catalog, { prompt = "Elige un tema:" }, function(choice)
        if choice then
          apply_and_persist(choice)
        end
      end)
    elseif M.is_valid(arg) then
      -- Con argumento valido: aplicar directamente.
      apply_and_persist(arg)
    else
      -- Argumento desconocido: avisar sin tocar nada.
      vim.notify(
        "SCEPTIC: tema desconocido '" .. arg .. "'. Opciones: " .. table.concat(M.catalog, ", "),
        vim.log.levels.WARN
      )
    end
  end, {
    nargs = "?",
    complete = function()
      return M.catalog
    end,
    desc = "Cambia y guarda el tema de SCEPTIC-NVIM",
  })
end

return M
