-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    ["<S-L>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-H>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },

    ["<C-Left>"] = false,
    ["<C-q>"] = false,
    ["<C-Right>"] = false,

    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    ["<C-z>"] = { ":u<cr>", desc = "Undo" },
    ["<C-a>"] = { "ggVG", desc = "Select All" },

    ["<C-Left>"]  = {"b", desc = "jump one word back"},
    ["<C-Right>"] = {"e", desc = "jump one word forward"},
    ["<C-V>"] = {'"+gP', desc = "paste from OS clipboard"},
    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<C-t>"] = {":ToggleTerm direction=float<CR>"}
  },
  i = {
    ["<C-V>"] = {'<ESC>"+pA', desc = "paste from OS clipboard"},
  },
  v = {
    ["<C-C>"] = {'"+y', desc = "copy to OS clipboard"},
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
    ["<C-t>"] = {"<C-d>"}
  },
}
