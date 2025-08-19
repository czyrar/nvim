-- Format files
return {
  'stevearc/conform.nvim',
  event = { 'LspAttach', 'BufWritePre' },
  dependencies = { 'j-hui/fidget.nvim' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '=f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable autoformat on certain filetypes
      local ignore_filetypes = {}
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = require 'mappings.formatters',
  },
  config = function(_, opts)
    local conform = require 'conform'
    conform.setup(opts)

    -- If condition false then disable
    local formattersconf = require 'config.formatters'
    local ctx = { filename = vim.api.nvim_buf_get_name(0) }
    ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
    for _, conf in ipairs(formattersconf) do
      if conf.condition and not conf.condition(ctx) then
        require('fidget').notify('Autoformat disabled on current buffer', vim.log.levels.INFO)
        vim.b.disable_autoformat = true
      end
    end

    -- Merge our config with the defaults
    for formatter, conf in pairs(formattersconf) do
      if conf.pre_args then
        conform.formatters[formatter] = { prepend_args = conf.pre_args }
      end
    end

    -- Commands to enable/disable the autoformat on save
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      -- FormatDisable! will disable formatting just for this buffer
      if args.bang then
        require('fidget').notify('Autoformat disabled on current buffer', vim.log.levels.INFO)
        vim.b.disable_autoformat = true
      else
        require('fidget').notify('Autoformat disabled', vim.log.levels.INFO)
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('FormatEnable', function()
      require('fidget').notify('Autoformat enabled', vim.log.levels.INFO)
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
