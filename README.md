# SCEPTIC-NVIM

A standalone, cross-platform Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim). The whole config lives under `nvim/`, so you can copy or symlink it straight into your Neovim config directory.

Works the same on Linux, macOS and Windows, and targets Neovim >= 0.11.3.

## Quick start

```bash
# Linux / macOS
curl -fsSL https://raw.githubusercontent.com/SCEPTICG/SCEPTIC-NVIM/main/install.sh | sh
```

```powershell
# Windows PowerShell
irm https://raw.githubusercontent.com/SCEPTICG/SCEPTIC-NVIM/main/install.ps1 | iex
```

On first launch, `lazy.nvim` installs every plugin automatically. See the [Installation](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Installation) page for manual steps, requirements and how to test a branch.

## Documentation

Everything lives in the [wiki](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki):

- [Installation](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Installation) — one-command and manual install, testing a branch, first run.
- [Keymaps](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Keymaps) — every keybinding, including the custom j/k/l/ñ movement for ISO Spanish keyboards.
- [Plugins](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Plugins) — what each plugin does.
- [Structure](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Structure) — folder layout and load order.
- [Maintenance](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Maintenance) — updating plugins, health checks, CI and rollback.
