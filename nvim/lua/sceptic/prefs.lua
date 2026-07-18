-- SCEPTIC-NVIM: modulo lector (y ahora tambien escritor) de preferencias.
--
-- Lee el fichero JSON de preferencias que vive junto a la configuracion
-- (sceptic-prefs.json en la raiz del directorio de config de Neovim) y expone
-- los valores resueltos fusionando los defaults con lo leido.
--
-- Diseno "a prueba de fallos": si el fichero no existe, no se puede leer o el
-- JSON esta corrupto, se usan los defaults. El arranque de Neovim NUNCA debe
-- fallar por culpa de este modulo.
--
-- FORMA DEL MODULO (importante, cambio en Fase 2A):
--   Antes (Fase 1) este modulo hacia `return build()`, es decir, devolvia una
--   tabla PLANA con los valores. Ahora devuelve una tabla `M` que:
--     * Sigue exponiendo los valores como campos directos, asi que el uso de
--       siempre NO cambia:  require("sceptic.prefs").theme  ->  "tokyonight".
--     * Ademas expone una funcion  M.set(key, value)  que actualiza el valor en
--       memoria y reescribe sceptic-prefs.json (fallo seguro con pcall). Sirve
--       para persistir cambios en caliente, p. ej. al elegir tema con
--       :ScepticTheme.
--   Como Lua cachea los modulos, todos los ficheros que hacen
--   require("sceptic.prefs") comparten la MISMA tabla, de modo que un M.set()
--   tambien queda reflejado en memoria para quien ya la tuviera.

-- Defaults canonicos. Deben coincidir exactamente con sceptic-prefs.json.
-- Ademas, sus claves definen el conjunto de claves "conocidas": solo estas se
-- leen del JSON, se pueden escribir con set() y se persisten.
local defaults = {
  theme = "tokyonight", -- tema por defecto de LazyVim
  movement = "hjkl", -- movimiento de fabrica ("jklñ" para teclado ISO español)
  explorer_side = "left", -- lado del explorador neo-tree (por defecto en LazyVim)
  tabs_style = "horizontal", -- estilo de pestañas/bufferline (Fase 2B)
  extras = {}, -- lista de extras de LazyVim a importar (vacia = ninguno)
}

-- Ruta del fichero de preferencias, junto a la config de Neovim.
local function prefs_path()
  return vim.fn.stdpath("config") .. "/sceptic-prefs.json"
end

-- Devuelve una copia superficial de los defaults, para no mutar la tabla base.
local function copy_defaults()
  return vim.deepcopy(defaults)
end

-- Lee y decodifica el fichero de preferencias. Devuelve una tabla o nil.
local function read_prefs_file()
  local path = prefs_path()

  -- Comprobamos que el fichero exista y sea legible antes de tocarlo.
  if vim.fn.filereadable(path) ~= 1 then
    return nil
  end

  -- vim.fn.readfile devuelve la lista de lineas; las unimos en una cadena.
  local ok_read, lines = pcall(vim.fn.readfile, path)
  if not ok_read or type(lines) ~= "table" then
    return nil
  end

  local content = table.concat(lines, "\n")
  if content == "" then
    return nil
  end

  -- Decodificamos con pcall: si el JSON esta corrupto, no petamos.
  local ok_decode, decoded = pcall(vim.json.decode, content)
  if not ok_decode or type(decoded) ~= "table" then
    return nil
  end

  return decoded
end

-- Construye la tabla final: defaults + lo leido del fichero (lo leido manda).
local function build()
  local prefs = copy_defaults()

  local user = read_prefs_file()
  if user then
    -- Fusion superficial clave a clave. Solo sobrescribimos claves conocidas y
    -- respetamos el tipo por defecto, para blindar contra JSON malformado.
    for key, default_value in pairs(defaults) do
      local value = user[key]
      if value ~= nil and type(value) == type(default_value) then
        prefs[key] = value
      end
    end
  end

  return prefs
end

-- Tabla que devuelve el modulo. Volcamos en ella los valores resueltos (una
-- sola vez, al requerir el modulo) y le colgamos la funcion set().
local M = {}
for key, value in pairs(build()) do
  M[key] = value
end

-- set(key, value): actualiza una preferencia en memoria y reescribe el JSON.
--
-- Fallo seguro: valida clave y tipo; si algo va mal avisa con vim.notify y
-- devuelve false SIN romper. Devuelve true si se persistio correctamente.
function M.set(key, value)
  -- Solo permitimos claves conocidas (las de defaults).
  if defaults[key] == nil then
    vim.notify("SCEPTIC: preferencia desconocida '" .. tostring(key) .. "'", vim.log.levels.WARN)
    return false
  end

  -- El tipo del valor debe coincidir con el del default, para no corromper el JSON.
  if type(value) ~= type(defaults[key]) then
    vim.notify(
      "SCEPTIC: tipo invalido para '"
        .. tostring(key)
        .. "' (se esperaba "
        .. type(defaults[key])
        .. ")",
      vim.log.levels.WARN
    )
    return false
  end

  -- Actualizamos en memoria.
  M[key] = value

  -- Reconstruimos SOLO con las claves conocidas (nunca serializamos la funcion set).
  local data = {}
  for k in pairs(defaults) do
    data[k] = M[k]
  end

  -- Codificamos y escribimos con pcall: cualquier fallo se avisa pero no rompe.
  local ok_encode, encoded = pcall(vim.json.encode, data)
  if not ok_encode or type(encoded) ~= "string" then
    vim.notify("SCEPTIC: no se pudo codificar las preferencias a JSON", vim.log.levels.ERROR)
    return false
  end

  local ok_write = pcall(vim.fn.writefile, vim.split(encoded, "\n"), prefs_path())
  if not ok_write then
    vim.notify("SCEPTIC: no se pudo escribir sceptic-prefs.json", vim.log.levels.ERROR)
    return false
  end

  return true
end

return M
