-- Format files
local conform = require 'conform'
local fidget = require 'fidget'

-- Local config
local config = {
  findent = {
    prepend_args = { '-i', '2' },
  },
  fprettify = {
    prepend_args = { '-i', '2', '--enable-decl', '--c-relations', '--enable-replacements', '--case', '1', '1', '1', '1' },
  },
}
local formatters_by_ft = {
  bash = { 'shfmt' },
  fortran = { 'findent', 'fprettify' },
  lua = { 'stylua' },
  markdown = { 'markdownlint' },
  python = { 'autopep8', 'ruff' },
  rust = { 'rustfmt' },
  sh = { 'shfmt' },
  tex = { 'bibtex-tidy', 'latexindent' },
  zsh = { 'shfmt' },
}

conform.setup {
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
    stop_after_first = true,
  },
  formatters_by_ft = formatters_by_ft,
}

-- If condition false then disable
local ctx = { filename = vim.api.nvim_buf_get_name(0) }
ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
for _, conf in ipairs(config) do
  if conf.condition and not conf.condition(ctx) then
    fidget.notify('Autoformat disabled on current buffer', vim.log.levels.INFO)
    vim.b.disable_autoformat = true
  end
end

-- Merge our config with the defaults
conform.formatters = vim.tbl_deep_extend('force', conform.formatters, config)

-- Keybind to run
vim.keymap.set('n', '=f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

-- Commands to enable/disable the autoformat on save
vim.api.nvim_create_user_command('FormatDisable', function(args)
  -- FormatDisable! will disable formatting just for this buffer
  if args.bang then
    fidget.notify('Autoformat disabled on current buffer', vim.log.levels.INFO)
    vim.b.disable_autoformat = true
  else
    fidget.notify('Autoformat disabled', vim.log.levels.INFO)
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
