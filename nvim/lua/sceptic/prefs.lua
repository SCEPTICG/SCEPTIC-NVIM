-- SCEPTIC-NVIM: modulo lector de preferencias.
--
-- Lee el fichero JSON de preferencias que vive junto a la configuracion
-- (sceptic-prefs.json en la raiz del directorio de config de Neovim) y expone
-- la tabla resultante fusionando los defaults con lo leido.
--
-- Diseno "a prueba de fallos": si el fichero no existe, no se puede leer o el
-- JSON esta corrupto, se usan los defaults. El arranque de Neovim NUNCA debe
-- fallar por culpa de este modulo.
--
-- IMPORTANTE (Fase 1): los defaults equivalen a LazyVim de fabrica, de modo que
-- con las preferencias por defecto el comportamiento no cambia. La logica que
-- APLICA cada preferencia vive en los ficheros de lua/plugins/ (tema, explorador)
-- y en config/lazy.lua (extras). Este modulo solo se encarga de LEER.

-- Defaults canonicos. Deben coincidir exactamente con sceptic-prefs.json.
local defaults = {
  theme = "tokyonight", -- tema por defecto de LazyVim
  movement = "hjkl", -- movimiento de fabrica (Fase 2: "jklñ" para teclado ISO español)
  explorer_side = "left", -- lado del explorador neo-tree (por defecto en LazyVim)
  tabs_style = "horizontal", -- estilo de pestañas/bufferline (Fase 2)
  extras = {}, -- lista de extras de LazyVim a importar (vacia = ninguno)
}

-- Devuelve una copia superficial de los defaults, para no mutar la tabla base.
local function copy_defaults()
  return vim.deepcopy(defaults)
end

-- Lee y decodifica el fichero de preferencias. Devuelve una tabla o nil.
local function read_prefs_file()
  local path = vim.fn.stdpath("config") .. "/sceptic-prefs.json"

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

-- La tabla de preferencias ya resuelta. Se calcula una sola vez al requerir el
-- modulo (Lua cachea los modulos), asi que todos los ficheros que la usan ven
-- el mismo resultado.
return build()
