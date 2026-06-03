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
