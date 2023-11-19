local M = {}

function M.send_visual_lines()
  -- visual markers only update after leaving visual mode
  local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)

  -- get selected text
  local start_line = vim.api.nvim_buf_get_mark(0, "<")[1]
  local end_line = vim.api.nvim_buf_get_mark(0, ">")[1]
  local lines = vim.fn.getline(start_line, end_line)

  -- send selection with trimmed indent
  local toggleterm = require "toggleterm"
  local indent = nil
  for _, line in ipairs(lines) do
    if indent == nil and line:find "[^%s]" ~= nil then indent = line:find "[^%s]" end
    toggleterm.exec(line:sub(indent or 1), 1)
  end

  toggleterm.exec(string.char(13))
end

return M
