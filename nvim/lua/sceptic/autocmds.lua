local group = vim.api.nvim_create_augroup("sceptic", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
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
    map("[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, "Diagnostico anterior")
    map("]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, "Diagnostico siguiente")
  end,
})
