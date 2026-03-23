local M = {}

function M.current_mode()
  return 'light'
end

function M.apply()
  vim.o.background = 'light'
  vim.cmd('silent colorscheme shine')
end

return M
