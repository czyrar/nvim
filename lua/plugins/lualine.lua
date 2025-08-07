-- Status bar customized to mimic mini.statusbar
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = vim.g.have_nerd_font,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        ignore_focus = {},
      },
      sections = {
        lualine_a = {
          function()
            local mode = require('lualine.utils.mode').get_mode()
            return string.sub(mode, 1, 1)
          end,
        },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype', 'encoding' },
        lualine_y = { 'progress' },
        lualine_z = {
          function()
            local line = vim.fn.line '.'
            local nlines = vim.fn.line '$'
            local col = vim.fn.charcol '.'
            local ncols = vim.fn.charcol '$' - 1
            return string.format('%3d|%-2d │ %3d|%-2d', col, ncols, line, nlines)
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {
          function()
            local line = vim.fn.line '.'
            local nlines = vim.fn.line '$'
            local col = vim.fn.charcol '.'
            local ncols = vim.fn.charcol '$' - 1
            return string.format('%3d|%-2d │ %3d|%-2d', col, ncols, line, nlines)
          end,
        },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
