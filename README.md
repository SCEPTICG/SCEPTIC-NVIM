# SCEPTIC-NVIM

Configuración moderna y standalone de Neovim para Windows, Linux y macOS.
El repositorio mantiene la configuración instalable dentro de `nvim/`, de forma
que se pueda copiar o enlazar al directorio de configuración de Neovim sin
depender del resto del proyecto.

## Requisitos

- Neovim 0.11.3 o superior.
- Git, necesario para clonar el repositorio y para que `lazy.nvim` descargue plugins.
- Una Nerd Font instalada y seleccionada en la terminal para ver iconos.
- Terminal moderna con color verdadero.
- Herramientas CLI recomendadas: `rg`, `fd`, `stylua`, `black`, `beautysh` y `prettier`.

## Instalación

Antes de instalar, haz copia de seguridad de una configuración anterior si ya
existe.

### Un comando

Windows PowerShell:

```powershell
irm https://raw.githubusercontent.com/SCEPTICG/SCEPTIC-NVIM/main/install.ps1 | iex
```

Linux/macOS:

```bash
curl -fsSL https://raw.githubusercontent.com/SCEPTICG/SCEPTIC-NVIM/main/install.sh | sh
```

Para probar una rama concreta antes de mezclarla en `main`, define `SCEPTIC_NVIM_BRANCH`.

PowerShell:

```powershell
$env:SCEPTIC_NVIM_BRANCH = "codex/modern-cross-platform-nvim"; irm https://raw.githubusercontent.com/SCEPTICG/SCEPTIC-NVIM/codex/modern-cross-platform-nvim/install.ps1 | iex
```

Bash/Zsh:

```bash
SCEPTIC_NVIM_BRANCH=codex/modern-cross-platform-nvim sh -c "$(curl -fsSL https://raw.githubusercontent.com/SCEPTICG/SCEPTIC-NVIM/codex/modern-cross-platform-nvim/install.sh)"
```

### Windows PowerShell

```powershell
if (Test-Path $env:LOCALAPPDATA\nvim) {
    Rename-Item $env:LOCALAPPDATA\nvim "nvim.backup.$(Get-Date -Format yyyyMMddHHmmss)"
}

git clone https://github.com/SCEPTICG/SCEPTIC-NVIM.git $env:LOCALAPPDATA\nvim-sceptic
Copy-Item -Recurse $env:LOCALAPPDATA\nvim-sceptic\nvim $env:LOCALAPPDATA\nvim
```

### Linux

```bash
if [ -d ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d%H%M%S)
fi

git clone https://github.com/SCEPTICG/SCEPTIC-NVIM.git ~/.config/nvim-sceptic
cp -r ~/.config/nvim-sceptic/nvim ~/.config/nvim
```

### macOS

```bash
if [ -d ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d%H%M%S)
fi

git clone https://github.com/SCEPTICG/SCEPTIC-NVIM.git ~/.config/nvim-sceptic
cp -r ~/.config/nvim-sceptic/nvim ~/.config/nvim
```

## Primer inicio

Abre Neovim y deja que `lazy.nvim` instale los plugins:

```bash
nvim
```

Después, revisa el estado de plugins, herramientas externas y salud general:

```vim
:Lazy
:Mason
:checkhealth
```

Los servidores LSP y los formateadores (stylua, black, prettier, beautysh) se instalan
solos vía `mason-lspconfig` y `mason-tool-installer`. Los parsers de Treesitter se
instalan con `:TSInstall <lenguaje>`.

## Estructura

- `nvim/init.lua`: entrypoint mínimo de la configuración.
- `nvim/lua/sceptic/`: opciones, keymaps, autocmds y bootstrap de Lazy.
- `nvim/lua/plugins/`: specs enfocadas de plugins para `lazy.nvim`.
- `nvim/lazy-lock.json`: lockfile generado por `lazy.nvim` para fijar versiones.
- `docs/superpowers/plans/`: planes de trabajo y revision estatica del proyecto.

## Mantenimiento básico

- Actualiza plugins desde Neovim con `:Lazy update`.
- Revisa cambios pendientes con `:Lazy log` antes de confirmar una actualización grande.
- Sincroniza herramientas externas con `:Mason` cuando cambien LSPs o formateadores.
- Ejecuta `:checkhealth` despues de actualizar Neovim, cambiar de sistema operativo o tocar dependencias.
- Conserva `nvim/lazy-lock.json` cuando quieras instalaciones reproducibles; regeneralo solo tras actualizar plugins.
- Mantén la configuración portable: evita rutas absolutas de un sistema operativo en specs de plugins.
- El LSP usa la API moderna `vim.lsp.config()` mediante `mason-lspconfig`, por eso requiere Neovim 0.11.3+.

## Notas multi-OS

- En Windows, usa PowerShell moderno y comprueba que `git` y `nvim` están en `PATH`.
- En Linux y macOS, la ruta esperada de Neovim es `~/.config/nvim`.
- Las herramientas opcionales pueden instalarse con el gestor de paquetes del sistema, Mason o gestores de lenguaje como `npm`, `pip` y `cargo`.
