-- ~/.config/nvim/lua/core/keymaps.lua
vim.g.mapleader = " "

local keymap = vim.keymap -- Para abreviar

-- Explorador de archivos (NvimTree)
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Abrir/Cerrar Explorador" })

-- Buscador de archivos (Telescope)
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Buscar archivos" })
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Buscar texto en archivos" })

-- Navegación de buffers (pestañas)
keymap.set("n", "<S-l>", ":bnext<CR>")
keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Salir rápido
keymap.set("n", "<leader>q", ":q<CR>")
keymap.set("n", "<leader>w", ":w<CR>")
