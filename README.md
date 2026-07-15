<div align="center">

# 💤 SCEPTIC-NVIM

A modern, standalone Neovim config for Windows, Linux and macOS, built on top of [lazy.nvim](https://github.com/folke/lazy.nvim).

<!-- Add a screenshot here once you have one: place screenshot.png in the repo root and uncomment:
<img src="screenshot.png" alt="SCEPTIC-NVIM screenshot" width="800" /> -->

</div>

<p align="center">
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Installation">Installation</a> •
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Keymaps">Keymaps</a> •
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki">Docs</a>
</p>

<p align="center">
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/SCEPTICG/SCEPTIC-NVIM/ci.yml?branch=main&style=for-the-badge" /></a>
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM/commits/main"><img alt="Last commit" src="https://img.shields.io/github/last-commit/SCEPTICG/SCEPTIC-NVIM?style=for-the-badge" /></a>
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/SCEPTICG/SCEPTIC-NVIM?style=for-the-badge" /></a>
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/SCEPTICG/SCEPTIC-NVIM?style=for-the-badge" /></a>
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM/issues"><img alt="Issues" src="https://img.shields.io/github/issues/SCEPTICG/SCEPTIC-NVIM?style=for-the-badge" /></a>
  <a href="https://github.com/SCEPTICG/SCEPTIC-NVIM"><img alt="Repo size" src="https://img.shields.io/github/repo-size/SCEPTICG/SCEPTIC-NVIM?style=for-the-badge" /></a>
</p>

SCEPTIC-NVIM is a personal, standalone Neovim configuration — not a distribution framework. It lives entirely in the `nvim/` folder, so it drops straight into your Neovim config directory with no extra layer on top. LSP, autocompletion, formatting, file search and git status all work out of the box, and plugin versions are pinned via `lazy-lock.json` for reproducible installs.

## ✨ Features

- 💤 Plugin management via [lazy.nvim](https://github.com/folke/lazy.nvim), with versions pinned in `lazy-lock.json`
- 🚀 LSP out of the box via `mason.nvim` + `mason-lspconfig`, with completion powered by [blink.cmp](https://github.com/Saghen/blink.cmp)
- 🌳 Syntax-aware editing with `nvim-treesitter`
- 🔍 Fuzzy finding for files, text and buffers with `telescope.nvim`
- 🎨 Auto-format on save with `conform.nvim`, formatters installed automatically via `mason-tool-installer`
- 🔀 Git status in the sign column and hunk actions with `gitsigns.nvim`
- ⌨️ On-demand keymap hints with `which-key.nvim`
- 🎨 Catppuccin (mocha) theme wired into every plugin
- 🇪🇸 Custom **j/k/l/ñ** movement for ISO Spanish keyboards (`h` is disabled) — see [Keymaps](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Keymaps)

## ⚡️ Requirements

- Neovim >= 0.11.3 (LuaJIT build)
- Git
- A [Nerd Font](https://www.nerdfonts.com/), set in your terminal
- A C compiler, needed by `nvim-treesitter` to build parsers
- Recommended: `rg` (ripgrep) and `fd` for faster Telescope searches

Formatters (`stylua`, `black`, `prettier`, `beautysh`) and LSP servers are installed automatically by `mason-tool-installer` and `mason-lspconfig` — no manual setup needed.

## 🚀 Getting Started

> [!IMPORTANT]
> The installers back up any existing config automatically, but if you've customized it, check the backup before wiping it.

**Linux / macOS:**

```bash
curl -fsSL https://raw.githubusercontent.com/SCEPTICG/SCEPTIC-NVIM/main/install.sh | sh
```

**Windows (PowerShell):**

```powershell
irm https://raw.githubusercontent.com/SCEPTICG/SCEPTIC-NVIM/main/install.ps1 | iex
```

<details>
<summary>Manual installation by OS</summary>

See the [Installation](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Installation) wiki page for step-by-step manual instructions on Linux, macOS and Windows, plus how to test a specific branch with `SCEPTIC_NVIM_BRANCH`.

</details>

Then open Neovim and let `lazy.nvim` install the plugins:

```bash
nvim
```

## 📂 Structure

```
nvim/
├── init.lua              -- entrypoint, requires sceptic
├── lua/
│   ├── sceptic/           -- options, keymaps, autocmds, lazy.nvim bootstrap
│   └── plugins/            -- one spec file per plugin, auto-loaded by lazy.nvim
└── lazy-lock.json         -- pinned plugin versions
```

Full breakdown in [Structure](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki/Structure).

## ⚙️ Docs

Everything else — full keymap tables, plugin list, folder structure and maintenance — lives in the **[wiki](https://github.com/SCEPTICG/SCEPTIC-NVIM/wiki)**.
