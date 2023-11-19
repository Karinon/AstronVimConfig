--local condition = require "astronvim.utils.status.condition"

return {
  {
    "rebelot/heirline.nvim",
    --  attributes = {
    --    mode = { bold = true },
    --  },
    --  icon_highlights = {
    --    file_icon = {
    --      statusline = false,
    --    },
    --  },
    --},
    opts = function(_, opts)
      local status = require "astronvim.utils.status"
      --  opts.separators = {
      -- left = { "", "█ " }, -- separator for the left side of the statusline
      --  },
      opts.statusline = {
        -- default highlight for the entire statusline
        hl = { fg = "fg", bg = "bg" },
        -- each element following is a component in astronvim.utils.status module
        -- add the vim mode component
        status.component.mode {
          -- enable mode text with padding as well as an icon before it
          mode_text = { icon = { kind = "VimIcon", padding = { right = 1, left = 1 } } },
          -- surround the component with a separators
          surround = {
            -- it's a left element, so use the left separator
            separator = "left",
            -- set the color of the surrounding based on the current mode using astronvim.utils.status module
            color = function() return { main = status.hl.mode_bg() } end,
          },
        },
        {
          status.component.git_branch {
            surround = { separator = "none" },
            padding = { left = 1, right = 1 },
          },
          -- add a component for the current git diff if it exists and use no separator for the sections
          status.component.git_diff {
            padding = { right = 1 },
            surround = { separator = "none" },
          },
        },

        -- we want an empty space here so we can use the component builder to make a new section with just an empty string
        status.component.file_info {
          filetype = false,
          filename = false,
          file_modified = false,
          hl = { fg = "#555555", bg = "file_bg" },
          surround = { separator = "none" },
        },
        --status.component.builder {
        --  { provider = require("astronvim.utils").get_icon "File" },
        --  hl = { fg = "#555555", bg = "file_bg" },
        --  padding = { right = 1 },
        --  -- define the surrounding separator and colors to be used inside of the component
        --  -- and the color to the right of the separated out section
        --  surround = { separator = "none" },
        --},
        -- add a section for the currently opened file information
        {
          status.component.separated_path {
            max_depth = 2,
            path_func = status.provider.filename {
              modify = ":.:h",
            },
            separator = "  ",
            hl = { fg = "#555555", bg = "file_bg" },
            suffix = true,
            padding = { left = 0, right = 0 },
            surround = { separator = "none", color = { main = "nav_icon_bg", left = "file_info_bg" } },
          },
          status.component.file_info {
            unique_path = {},
            file_icon = false,
            hl = { fg = "#555555", bg = "file_bg", bold = true },
            padding = { left = 0, right = 1 },
            surround = { separator = "none" }, --/*, color = { main = "nav_icon_bg", left = "file_info_bg" }*/ },
          },
        },

        -- fill the rest of the statusline
        -- the elements after this will appear in the middle of the statusline
        status.component.fill(),
        -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
        status.component.lsp { lsp_client_names = false, surround = { separator = "none", color = "bg" } },
        -- fill the rest of the statusline
        -- the elements after this will appear on the right of the statusline
        status.component.fill(),
        -- add a component for the current diagnostics if it exists and use the right separator for the section
        status.component.diagnostics { surround = { separator = "right" } },
        status.component.treesitter(),
        status.component.signcolumn(),
        --{
        --  status.component.builder {
        --    { provider = require("astronvim.utils").get_icon "Search" },
        --    -- add padding after icon
        --    padding = { right = 1 },
        --    -- set the icon foreground
        --    hl = { fg = "bg" },
        --    -- use the right separator and define the background color
        --    surround = { separator = "left", color = { main = "nav_icon_bg" } },
        --  },
        --  {
        --    provider = require("astronvim.utils.status").provider.search_count(),

        --    icon = { kind = "Search", padding = { right = 1 } },
        --    padding = { left = 1 },
        --  },
        --  condition = condition.is_hlsearch,
        --},
        --
        -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
        --
        require("astronvim.utils.status").component.cmd_info(),
        status.component.lsp {
          lsp_progress = false,
          -- surround = { separator = "none" },
          padding = { right = 1, left = 1 },

          hl = { icon = { kind = "search", padding = { right = 1 } } },
        },

        {
          provider = function() return "[" .. string.upper(vim.bo.filetype) .. "]" end,
          hl = { fg = "fg", bold = true },
        },

        { -- make nav section with icon border
          -- define a custom component with just a file icon
          status.component.builder {
            { provider = require("astronvim.utils").get_icon "ScrollText" },
            -- add padding after icon
            padding = { right = 1 },
            -- set the icon foreground
            hl = { fg = "bg" },
            -- use the right separator and define the background color
            surround = { separator = "right", color = { main = "nav_icon_bg" } },
          },
          -- add a navigation component and just display the percentage of progress in the file
          status.component.nav {
            -- add some padding for the percentage provider
            --percentage = { padding = { right = 1 } },
            -- disable all other providers
            ruler = { provider = " %7(%l/%3L%):%2c %P" },
            scrollbar = {
              provider = require("astronvim.utils.status").provider.scrollbar(),
              padding = { right = 0, left = 0 },
            },
            hl = { fg = "bg" },
            -- use no separator and define the background color
            surround = { separator = "none", color = { main = "nav_icon_bg" } },
          },
        },
      }

      ---- return the final options table
      return opts
    end,
  },
}
