# Plan de Implementacion de NVIM Moderno y Multi-OS

> **Para agentes de trabajo:** SUB-SKILL REQUERIDO: usar `superpowers:subagent-driven-development` recomendado o `superpowers:executing-plans` para implementar este plan tarea por tarea. Los pasos usan casillas (`- [ ]`) para poder seguir el progreso.

**Objetivo:** Reconstruir SCEPTIC-NVIM como una configuracion moderna, standalone y compatible con Windows, Linux y macOS.

**Arquitectura:** Mantener `nvim/` como raiz instalable de la configuracion. Mover la configuracion base a `lua/sceptic/` y dejar que Lazy importe specs de plugins enfocadas desde `lua/plugins/*.lua`. Centralizar deteccion de sistema operativo y comportamiento dependiente del entorno en `sceptic/utils.lua`, para que los plugins se mantengan portables.

**Stack:** Neovim 0.11.3+, Neovim Lua, lazy.nvim, blink.cmp, nvim-lspconfig, mason.nvim, mason-lspconfig.nvim, conform.nvim, nvim-treesitter, telescope.nvim, nvim-tree.lua, catppuccin y lualine.nvim.

---

## Estructura de Archivos

- Crear `nvim/lua/sceptic/init.lua`: carga options, keymaps, autocmds y bootstrap de Lazy.
- Crear `nvim/lua/sceptic/options.lua`: opciones portables del editor.
- Crear `nvim/lua/sceptic/keymaps.lua`: keymaps globales y helper pequeno para mappings.
- Crear `nvim/lua/sceptic/autocmds.lua`: autocmds reutilizables para mejoras de uso diario.
- Crear `nvim/lua/sceptic/utils.lua`: helpers de deteccion de SO y ejecutables.
- Crear `nvim/lua/sceptic/lazy.lua`: bootstrap y setup de lazy.nvim.
- Reemplazar `nvim/init.lua`: entrypoint minimo que requiere `sceptic`.
- Modificar `nvim/lua/plugins/init.lua`: dejarlo vacio para evitar duplicados.
- Modificar `nvim/lua/plugins/*.lua`: convertir los archivos existentes en specs Lazy enfocadas.
- Crear o actualizar `README.md`: documentacion de instalacion y mantenimiento para Windows, Linux y macOS.

## Tarea 1: Entrypoint Base y Bootstrap de Lazy

**Archivos:**
- Modificar: `nvim/init.lua`
- Crear: `nvim/lua/sceptic/init.lua`
- Crear: `nvim/lua/sceptic/lazy.lua`

- [ ] **Paso 1: Reemplazar el entrypoint raiz**

Escribir `nvim/init.lua` asi:

```lua
require("sceptic")
```

- [ ] **Paso 2: Crear el cargador principal de SCEPTIC**

Escribir `nvim/lua/sceptic/init.lua` asi:

```lua
require("sceptic.options")
require("sceptic.keymaps")
require("sceptic.autocmds")
require("sceptic.lazy")
```

- [ ] **Paso 3: Crear bootstrap moderno de Lazy**

Escribir `nvim/lua/sceptic/lazy.lua` asi:

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to install lazy.nvim:\n", "ErrorMsg" },
      { result, "WarningMsg" },
    }, true, {})
    return
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
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
```

- [ ] **Paso 4: Verificar sintaxis del bootstrap**

Ejecutar:

```powershell
Get-Content nvim\init.lua
Get-Content nvim\lua\sceptic\lazy.lua
```

Resultado esperado: los archivos contienen el nuevo loader y el setup de Lazy con `{ import = "plugins" }`.

## Tarea 2: Configuracion Core Portable

**Archivos:**
- Crear: `nvim/lua/sceptic/utils.lua`
- Crear: `nvim/lua/sceptic/options.lua`
- Crear: `nvim/lua/sceptic/keymaps.lua`
- Crear: `nvim/lua/sceptic/autocmds.lua`

- [ ] **Paso 1: Anadir helpers de sistema operativo**

Escribir `nvim/lua/sceptic/utils.lua` asi:

```lua
local M = {}

local sysname = vim.uv.os_uname().sysname

M.is_windows = sysname:match("Windows") ~= nil
M.is_macos = sysname == "Darwin"
M.is_linux = sysname == "Linux"

function M.has(executable)
  return vim.fn.executable(executable) == 1
end

return M
```

- [ ] **Paso 2: Anadir opciones portables**

Escribir `nvim/lua/sceptic/options.lua` asi:

```lua
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.laststatus = 3
opt.showmode = false

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 400

opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
```

- [ ] **Paso 3: Anadir keymaps globales**

Escribir `nvim/lua/sceptic/keymaps.lua` asi:

```lua
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("n", "<leader>w", "<cmd>write<cr>", "Guardar archivo")
map("n", "<leader>q", "<cmd>quit<cr>", "Cerrar ventana")
map("n", "<leader>h", "<cmd>nohlsearch<cr>", "Limpiar resaltado de busqueda")

map("n", "<S-l>", "<cmd>bnext<cr>", "Buffer siguiente")
map("n", "<S-h>", "<cmd>bprevious<cr>", "Buffer anterior")

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", "Alternar arbol de archivos")
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Buscar archivos")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", "Buscar texto")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Buscar buffers")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Archivos recientes")

map("v", "<", "<gv", "Indentar a la izquierda")
map("v", ">", ">gv", "Indentar a la derecha")
```

- [ ] **Paso 4: Anadir autocmds**

Escribir `nvim/lua/sceptic/autocmds.lua` asi:

```lua
local group = vim.api.nvim_create_augroup("sceptic", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(event)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Ir a definicion")
    map("gr", vim.lsp.buf.references, "Ver referencias")
    map("gD", vim.lsp.buf.declaration, "Ir a declaracion")
    map("gi", vim.lsp.buf.implementation, "Ir a implementacion")
    map("<leader>rn", vim.lsp.buf.rename, "Renombrar simbolo")
    map("<leader>ca", vim.lsp.buf.code_action, "Acciones de codigo")
    map("[d", vim.diagnostic.goto_prev, "Diagnostico anterior")
    map("]d", vim.diagnostic.goto_next, "Diagnostico siguiente")
  end,
})
```

- [ ] **Paso 5: Verificar que existen los archivos core**

Ejecutar:

```powershell
Get-ChildItem nvim\lua\sceptic
```

Resultado esperado: aparecen `init.lua`, `lazy.lua`, `utils.lua`, `options.lua`, `keymaps.lua` y `autocmds.lua`.

## Tarea 3: Specs de Plugins por Dominio

**Archivos:**
- Modificar: `nvim/lua/plugins/init.lua`
- Modificar: `nvim/lua/plugins/nvim-tree.lua`
- Modificar: `nvim/lua/plugins/treesitter.lua`
- Modificar: `nvim/lua/plugins/formatting.lua`
- Modificar: `nvim/lua/plugins/terminal.lua`
- Modificar: `nvim/lua/plugins/dashboard.lua`
- Modificar: `nvim/lua/plugins/indent.lua`
- Modificar: `nvim/lua/plugins/comments.lua`
- Modificar: `nvim/lua/plugins/autopairs.lua`
- Crear: `nvim/lua/plugins/ui.lua`
- Crear: `nvim/lua/plugins/telescope.lua`
- Crear: `nvim/lua/plugins/coding.lua`

- [ ] **Paso 1: Reemplazar la spec duplicada de init**

Escribir `nvim/lua/plugins/init.lua` asi:

```lua
return {}
```

- [ ] **Paso 2: Anadir plugins de UI**

Escribir `nvim/lua/plugins/ui.lua` asi:

```lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        blink_cmp = true,
        dashboard = true,
        mason = true,
        native_lsp = { enabled = true },
        nvimtree = true,
        telescope = true,
        treesitter = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        globalstatus = true,
      },
    },
  },
}
```

- [ ] **Paso 3: Anadir spec de Telescope**

Escribir `nvim/lua/plugins/telescope.lua` asi:

```lua
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
        },
      }
    end,
  },
}
```

- [ ] **Paso 4: Mantener nvim-tree con valores portables**

Escribir `nvim/lua/plugins/nvim-tree.lua` asi:

```lua
return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view = {
        width = 32,
        side = "right",
      },
      renderer = {
        group_empty = true,
        indent_markers = { enable = true },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
    },
  },
}
```

- [ ] **Paso 5: Anadir plugins de coding**

Escribir `nvim/lua/plugins/coding.lua` asi:

```lua
return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },
      completion = {
        documentation = { auto_show = true },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
```

- [ ] **Paso 6: Mantener specs enfocadas de utilidades**

Escribir estos archivos asi:

```lua
-- nvim/lua/plugins/autopairs.lua
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
```

```lua
-- nvim/lua/plugins/comments.lua
return {
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    opts = {},
  },
}
```

```lua
-- nvim/lua/plugins/indent.lua
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "|" },
      scope = { enabled = true },
      exclude = {
        filetypes = { "dashboard", "help", "terminal", "lazy", "mason", "toggleterm" },
      },
    },
  },
}
```

- [ ] **Paso 7: Verificar que las specs son importables**

Ejecutar:

```powershell
rg 'return \\{' nvim\lua\plugins
```

Resultado esperado: cada archivo de plugins devuelve una tabla Lazy o `{}`.

## Tarea 4: LSP, Treesitter, Formatting y Terminal

**Archivos:**
- Modificar: `nvim/lua/plugins/lsp.lua`
- Modificar: `nvim/lua/plugins/treesitter.lua`
- Modificar: `nvim/lua/plugins/formatting.lua`
- Modificar: `nvim/lua/plugins/terminal.lua`

- [ ] **Paso 1: Modernizar LSP para blink.cmp**

Escribir `nvim/lua/plugins/lsp.lua` asi:

```lua
return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "bashls", "jsonls", "yamlls" },
      automatic_enable = true,
    },
    config = function(_, opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        pyright = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end

      require("mason-lspconfig").setup(opts)
    end,
  },
}
```

- [ ] **Paso 2: Modernizar Treesitter**

Escribir `nvim/lua/plugins/treesitter.lua` asi:

```lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "bash", "json", "lua", "markdown", "python", "vim", "vimdoc", "yaml" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
```

- [ ] **Paso 3: Mantener Conform como formateador**

Escribir `nvim/lua/plugins/formatting.lua` asi:

```lua
return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        sh = { "beautysh" },
        bash = { "beautysh" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
    },
  },
}
```

- [ ] **Paso 4: Mantener ToggleTerm portable**

Escribir `nvim/lua/plugins/terminal.lua` asi:

```lua
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<c-t>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Alternar terminal" },
    },
    opts = {
      size = 20,
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    },
  },
}
```

- [ ] **Paso 5: Verificar que no queda la dependencia antigua de cmp**

Ejecutar:

```powershell
rg 'nvim-cmp|cmp-nvim-lsp|LuaSnip' nvim
```

Resultado esperado: sin coincidencias, salvo que el viejo `lazy-lock.json` aun no se haya regenerado por Neovim.

## Tarea 5: README y Verificacion Estatica

**Archivos:**
- Modificar: `README.md`

- [ ] **Paso 1: Escribir README multi-OS**

Escribir `README.md` asi:

```markdown
# SCEPTIC-NVIM

Configuracion moderna y standalone de Neovim para Windows, Linux y macOS.

## Requisitos

- Neovim 0.11.3 o superior
- Git
- Una Nerd Font para iconos
- Herramientas CLI opcionales: `rg`, `fd`, `stylua`, `black`, `beautysh`, `prettier`

## Instalacion

### Windows PowerShell

```powershell
git clone https://github.com/SCEPTICG/SCEPTIC-NVIM.git $env:LOCALAPPDATA\nvim-sceptic
Copy-Item -Recurse $env:LOCALAPPDATA\nvim-sceptic\nvim $env:LOCALAPPDATA\nvim
```

### Linux

```bash
git clone https://github.com/SCEPTICG/SCEPTIC-NVIM.git ~/.config/nvim-sceptic
cp -r ~/.config/nvim-sceptic/nvim ~/.config/nvim
```

### macOS

```bash
git clone https://github.com/SCEPTICG/SCEPTIC-NVIM.git ~/.config/nvim-sceptic
cp -r ~/.config/nvim-sceptic/nvim ~/.config/nvim
```

## Primer Inicio

Abrir Neovim y dejar que lazy.nvim instale los plugins:

```bash
nvim
```

Despues ejecutar:

```vim
:Lazy
:Mason
:checkhealth
```

## Estructura

- `nvim/init.lua`: entrypoint minimo
- `nvim/lua/sceptic/`: opciones, keymaps, autocmds, utilidades y bootstrap de Lazy
- `nvim/lua/plugins/`: specs enfocadas de plugins para Lazy
- `nvim/lazy-lock.json`: lockfile de plugins generado por lazy.nvim
```

- [ ] **Paso 2: Ejecutar checks estaticos**

Ejecutar:

```powershell
rg 'require\\("core|hrsh7th|cmp_nvim_lsp|pcall\\(require' nvim
```

Resultado esperado: sin coincidencias.

- [ ] **Paso 3: Ejecutar check con Neovim si esta disponible**

Ejecutar:

```powershell
nvim --headless "+Lazy! sync" +qa
```

Resultado esperado: Lazy instala o sincroniza plugins y Neovim sale correctamente. Si `nvim` no esta instalado en la shell actual, anotar que esa verificacion queda bloqueada en el resumen final.

- [ ] **Paso 4: Commit**

Ejecutar:

```powershell
git add README.md nvim docs/superpowers/plans/2026-06-02-modern-cross-platform-nvim.md
git commit -m "refactor: modernize cross-platform neovim config"
```

Resultado esperado: el commit se crea correctamente con la configuracion refactorizada.

## Auto-Revision

- Cobertura: el plan cubre soporte multi-OS, estructura moderna de Lazy, migracion a blink.cmp, mantenimiento de nvim-tree, LSP, formatting, UI, keymaps, rendimiento y README.
- Placeholders: no hay pasos con `TBD`, `TODO` ni instrucciones incompletas.
- Consistencia: se usa de forma consistente el namespace `sceptic`, specs Lazy y capacidades LSP de blink.cmp.
