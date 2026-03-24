vim.notify = function(msg, log_level, _opts)
    if msg:match("deprecated") or msg:match("lspconfig") then
        return
    end
    return vim.api.nvim_echo({ { msg } }, true, {})
end

-- 1. Rutas del sistema
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 2. Bootstrap (Descarga automática si no existe)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({ { "Error clonando lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- 3. Carga de configuraciones básicas
-- Nota: Asegúrate de que estos archivos existan en ~/.config/nvim/lua/core/
pcall(require, "core.options")
pcall(require, "core.keymaps")

-- 4. Configuración de Lazy (aquí le decimos que busque en lua/plugins/init.lua)
require("lazy").setup("plugins")
