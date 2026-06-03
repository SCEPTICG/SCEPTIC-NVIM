local M = {}

local sysname = vim.uv.os_uname().sysname

M.is_windows = sysname:match("Windows") ~= nil
M.is_macos = sysname == "Darwin"
M.is_linux = sysname == "Linux"

function M.has(executable)
  return vim.fn.executable(executable) == 1
end

return M
